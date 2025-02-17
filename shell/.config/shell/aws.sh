# aws
alias s3cp='aws s3 cp'
alias s3ls='aws s3 ls --human-readable'
alias s3mv='aws s3 mv'
alias s3rm='aws s3 rm'
alias aparallel='parallel --env AWS_SECRET_ACCESS_KEY --env AWS_SESSION_TOKEN --env AWS_ACCESS_KEY_ID'

function s3_undelete() {
  s3_bucket="$1"
  if [[ -z "${s3_bucket:-}" ]]; then
    echo "Missing S3 bucket argument"
    return
  fi

  s3_key="$2"
  if [[ -z "${s3_key:-}" ]]; then
    echo "Missing S3 key argument"
    return
  fi

  if (aws s3 ls "s3://${s3_bucket}/${s3_key}" &> /dev/null); then
    echo "s3://${s3_bucket}/${s3_key} is already undeleted"
    return
  fi

  version_id="$(aws s3api list-object-versions \
      --bucket "$s3_bucket" --prefix "$s3_key" \
      --query 'DeleteMarkers[?IsLatest==`true`]' \
    | jq -r '.[] | select(.IsLatest==true) | .VersionId')"

  aws s3api delete-object \
    --bucket "$s3_bucket" --key "$s3_key" \
    --version-id "$version_id"

  aws s3 ls "s3://${s3_bucket}/${s3_key}" \
    || echo "Failed to restore $s3_key"
}

function s3versions() {
  # Usage:
  # s3versions s3://{Bucket}/{Key}
  aws s3api list-object-versions \
    --bucket "$(sed -e 's|^s3://||' <<< "$1" | sed -e 's|/.*||')" \
    --prefix "$(sed -e 's|^s3://[^/]*/||' <<< "$1")" \
  | jq -c '.Versions[] | {key: .Key, date: .LastModified, version: .VersionId, size: .Size}' \
  | sort
}

function s3restoreversion() {
  # Usage:
  # s3restoreversion s3://{Bucket}/{Key} {VersionId}
  local source
  source="$(sed -e 's|^s3://||' <<< "$1")"
  local dest_bucket
  dest_bucket="$(sed -e 's|^s3://||' <<< "$1" | sed -e 's|/.*||')"
  local dest_key
  dest_key="$(sed -e 's|^s3://[^/]*/||' <<< "$1")"
  local version="$2"
  aws s3api copy-object \
    --copy-source "${source}?versionId=${version}" \
    --bucket "$dest_bucket" \
    --key "$dest_key"
}
