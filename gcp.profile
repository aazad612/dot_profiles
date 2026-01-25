gset() {
    local profile="$1"
    local csv="$HOME/gcloud/gcp_config.csv"

    if [ -z "$profile" ]; then
        echo "Usage: gset <de|you|admin>"
        return 1
    fi

    # Kill any stale ADC so we don't get quota warnings / confusion
    rm -f "$HOME/.config/gcloud/application_default_credentials.json"

    if [ ! -f "$csv" ]; then
        echo "Error: $csv not found at $csv"
        return 1
    fi

    # Find row in CSV (skip header)
    local line
    line=$(grep "^$profile," "$csv")
    if [ -z "$line" ]; then
        echo "Profile '$profile' not found in $csv"
        return 1
    fi

    # Parse CSV: profile,project,credentials_file,gcloud_config
    local prof gproject credfile gconf
    IFS=',' read -r prof gproject credfile gconf <<< "$line"

    # Expand $HOME in credentials path
    credfile="${credfile/\$HOME/$HOME}"

    if [ ! -f "$credfile" ]; then
        echo "Credentials file not found: $credfile"
        return 1
    fi

    # Environment vars for Python / VS Code / Terraform, etc.
    export GOOGLE_APPLICATION_CREDENTIALS="$credfile"
    export GOOGLE_CLOUD_PROJECT="$gproject"

    echo "Setting environment:"
    echo "  GOOGLE_APPLICATION_CREDENTIALS = $GOOGLE_APPLICATION_CREDENTIALS"
    echo "  GOOGLE_CLOUD_PROJECT          = $GOOGLE_CLOUD_PROJECT"

    # 1) Activate the right gcloud configuration FIRST
    gcloud config configurations activate "$gconf"

    # 2) Then activate the service account (this sets the active account)
    gcloud auth activate-service-account --key-file="$GOOGLE_APPLICATION_CREDENTIALS"

    # 3) Make config ACCOUNT match the active service account
    local acct
    acct=$(gcloud auth list --filter=status:ACTIVE --format="value(account)" | head -n1)
    echo "Active account from auth list: $acct"
    if [ -n "$acct" ]; then
        gcloud config set account "$acct"
    fi

    # 4) Set the project for this config
    gcloud config set project "$GOOGLE_CLOUD_PROJECT"

    echo "Switched to profile '$profile' (project: $GOOGLE_CLOUD_PROJECT)"
    gcloud config configurations list
}

GOOGLE_ZONE=$(gcloud  --quiet config get-value compute/zone --quiet)
GOOGLE_REGION=$(gcloud  --quiet config get-value compute/region --quiet)