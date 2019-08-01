function init(){
    export PGPASSFILE=$HOME/.pgpass
    echo "$POSTGRES_HOST:$POSTGRES_PORT:$POSTGRES_DB:$POSTGRES_USER:$POSTGRES_PASSWORD" > $PGPASSFILE
    chmod 600 $PGPASSFILE
}

function take_dump(){
    $PGDUMP_BIN -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER -d $POSTGRES_DB > $DUMP_FILE
}

function upload_2_s3(){
    echo "copying $DUMP_FILE to s3..."
    S3_URL="s3://$BUCKET_NAME/$BUCKET_PATH"
    STAMP=$(date +%F-%H-%M-%S)
    CMD="/opt/aws s3 cp $DUMP_FILE $S3_URL/${POSTGRES_DB}_${STAMP}.sql"
    echo $CMD
    eval ${CMD}
}

function notify_slack(){
    echo "$@"
    # TODO: implement this later
    # $SLACKTEE_SH_BIN "@"
}

function handler () {
    EVENT_DATA=$1
    RESPONSE="{\"statusCode\": 200, \"body\": \"Hello from Lambda!\"}"
    echo $RESPONSE
    export `cat .env|xargs`
    init

    take_dump
    ls -lah $DUMP_FILE
    upload_2_s3
    ls -lah $DUMP_FILE
    notify_slack "dumped and saved to s3"
}

