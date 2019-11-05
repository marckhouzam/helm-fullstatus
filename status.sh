#!/usr/bin/env bash
#
# Copyright 2019 Marc Khouzam <marc.khouzam@gmail.com>
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

set -e

usage="helm fullstatus RELEASE_NAME [flags]"
usage() {
    echo "Usage: $usage"
    exit 1
}

help() {
    echo "Helm plugin to show the status of kubernetes resources that are part of the specified helm release, similarly to how Helm v2 used to do."
    echo
    echo "Usage: $usage"
    echo
    echo "Flags: Same flags as the 'helm status' command"
    exit 0
}

release=""
for i in $@; do
    if [ "$i" = "-h" ] || [ "$i" = "--help" ]; then
        help
    elif [[ "${i}" != -* ]]; then
        release=$i
    fi
done

[ -z "${release}" ] && usage

context=""
[ -n "${HELM_KUBECONTEXT}" ] && context="--context $HELM_KUBECONTEXT"

$HELM_BIN status $@
echo;echo
$HELM_BIN get manifest $release | \
        kubectl get $context --namespace $HELM_NAMESPACE -f -