# Source: tgSolutionPack: https://github.com/TigerGraph-DevLabs/tgSolutionPack

## Check if gadmin is installed
command -v gadmin >/dev/null 2>&1 || { echo >&2 "TigerGraph is not installed  Aborting."; exit 1; }

## ensure tg is running and gsql is available
resp=$(gsql -v)
if [[ "$resp" == *"refused"* || "$resp" == *"not found"* ]]; then
    echo "Tigergraph does not appear to be running here."
    exit 0
fi

echo "Installing Fraud Schema, Data and Queries"
echo "This may take a while. Sit back and relax"
echo ""
		gsql ~/scripts/01-create-schema.gsql
		gsql ~/scripts/02-load-data.gsql
        gsql ~/scripts/SameReceiverSender.gsql
        gsql ~/scripts/GenerateUser.gsql
        gsql ~/scripts/GenerateTransaction.gsql
        gsql ~/scripts/GetRecentTransactions.gsql
        gsql ~/scripts/GetMetaInformation.gsql
