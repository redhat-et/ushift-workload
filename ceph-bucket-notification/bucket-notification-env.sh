BUCKET="my-ob-claim"
export AWS_HOST=$(kubectl -n default get cm ${BUCKET} -o jsonpath='{.data.BUCKET_HOST}')
export AWS_ACCESS_KEY_ID=$(kubectl -n default get secret ${BUCKET} -o jsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 --decode)
export AWS_SECRET_ACCESS_KEY=$(kubectl -n default get secret ${BUCKET} -o jsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 --decode)
export BUCKET_NAME=$(kubectl -n default get cm ${BUCKET} -o jsonpath='{.data.BUCKET_NAME}')


