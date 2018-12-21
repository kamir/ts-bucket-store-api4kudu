#!/bin/bash

PACKAGE_NAME=tsb_api4kudu
PACKAGE_VERSION=0.0.1
PACKAGE_NAME_CAML=tsb_4_kudu
PACKAGE_NAME_TITLE=tsb-kudu

SWAGGER_GEN_JAR=swagger-codegen/swagger-codegen-cli.jar
SWAGGER_DEF=../ts-bucket-store-api.yaml

rm -Rf clients/*
rm -Rf servers/*
rm -Rf docu/*

# Generate Python library
java -jar $SWAGGER_GEN_JAR generate -t swagger-codegen/modules/swagger-codegen/src/main/resources/python -i $SWAGGER_DEF -l python -o clients/python/ --additional-properties packageName=${PACKAGE_NAME},packageVersion=${PACKAGE_VERSION}

# Generate JavaScript library
java -jar $SWAGGER_GEN_JAR generate -t swagger-codegen/modules/swagger-codegen/src/main/resources/Javascript/ -i $SWAGGER_DEF -l javascript -o clients/javascript/ --additional-properties projectName=${PACKAGE_NAME},projectVersion=${PACKAGE_VERSION}

# Generate Java client library
java -jar $SWAGGER_GEN_JAR generate -t swagger-codegen/modules/swagger-codegen/src/main/resources/Java/ -i $SWAGGER_DEF -l java -o clients/java/ --additional-properties artifactId=${PACKAGE_NAME},artifactVersion=${PACKAGE_VERSION},invokerPackage=com.cloudera.kudu.api.invoker,modelPackage=com.cloudera.kudu.api.models,apiPackage=com.cloudera.kudu.api

# Generate python-flask server stub  
java -jar $SWAGGER_GEN_JAR generate -i $SWAGGER_DEF -l python-flask -o server/python-flask/ --additional-properties packageName=${PACKAGE_NAME_TITLE},packageVersion=${PACKAGE_VERSION}

# Generate python-flask server stub  
java -jar $SWAGGER_GEN_JAR generate -i $SWAGGER_DEF -l spring -o server/spring/ --additional-properties packageName=${PACKAGE_NAME_TITLE},packageVersion=${PACKAGE_VERSION}

# Generate API-Docs server stub   
java -jar $SWAGGER_GEN_JAR generate -i $SWAGGER_DEF -l html -o docu





#sed -i 's|self.host =.*|self.host = "http://localhost:8888/v2"|' clients/python/openalpr_api/configuration.py
#sed -i 's|private String basePath =.*|private String basePath = "http://localhost:8888/v2";|' clients/java/src/main/java/com/openalpr/api/invoker/ApiClient.java
