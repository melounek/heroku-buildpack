#!/usr/bin/env bash

move_dc_directories() {
  local BUILD_DIR="$1"
  local CACHE_DIR="$2"
  local BE_PROJECT_PATH="$3"
  local FE_PROJECT_PATH="$4"
  local TARGET_PATH="$5"

  if [ ! -d $BUILD_DIR ]; then
    echo "BUILD_DIR '$BUILD_DIR' directory does not exist"
    exit 1
  fi

  echo "creating cache: $CACHE_DIR"
  mkdir -p $CACHE_DIR
  if [ ! -d $CACHE_DIR ]; then
    echo "CACHE_DIR '$CACHE_DIR' directory does not exist"
    return 1
  fi

  if [ ! -d $BE_PROJECT_PATH ]; then
    echo "BE_PROJECT_PATH '$BE_PROJECT_PATH' directory does not exist"
    return 1
  fi

  if [ ! -d $FE_PROJECT_PATH ]; then
    echo "FE_PROJECT_PATH '$FE_PROJECT_PATH' directory does not exist"
    return 1
  fi

  echo "creating tmp dir in: $CACHE_DIR"
  TMP_DIR=`mktemp -d $CACHE_DIR/dc_backendXXXXX`
  echo "created tmp dir: $TMP_DIR"

  echo "moving backend dir: $BE_PROJECT_PATH to $TMP_DIR"
  cp -R $BE_PROJECT_PATH/. $TMP_DIR/


  echo "moving frontend dir: $FE_PROJECT_PATH to $TMP_DIR/$TARGET_PATH"
  mkdir -p $TMP_DIR/$TARGET_PATH
  cp -R $FE_PROJECT_PATH/. $TMP_DIR/$TARGET_PATH

  echo "cleaning build dir: $BUILD_DIR"
  rm -rf $BUILD_DIR/*

  echo "copying backend dir from cache: $TMP_DIR to build dir $BUILD_DIR"
  cp -R $TMP_DIR/. $BUILD_DIR/

  echo "cleaning tmp dir: $TMP_DIR"
  rm -rf $TMP_DIR
}
