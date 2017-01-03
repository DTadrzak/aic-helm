#!/bin/bash
set -ex
export HOME=/tmp

ansible localhost -vvv -m kolla_keystone_service -a "service_name=nova service_type=compute description='Openstack Compute' endpoint_region={{ .Values.keystone.nova_region_name }} url='http://nova-api:{{ .Values.network.port.api }}/v2/%(tenant_id)s' interface=admin region_name={{ .Values.keystone.admin_region_name }} auth='{{ include "keystone_auth" .}}'" -e "{'openstack_nova_auth':{{ include "keystone_auth" .}}}"
ansible localhost -vvv -m kolla_keystone_service -a "service_name=nova service_type=compute description='Openstack Compute' endpoint_region={{ .Values.keystone.nova_region_name }} url='http://nova-api:{{ .Values.network.port.api }}/v2/%(tenant_id)s' interface=internal region_name={{ .Values.keystone.admin_region_name }} auth='{{ include "keystone_auth" .}}'" -e "{'openstack_nova_auth':{{ include "keystone_auth" .}}}"
ansible localhost -vvv -m kolla_keystone_service -a "service_name=nova service_type=compute description='Openstack Compute' endpoint_region={{ .Values.keystone.nova_region_name }} url='http://nova-api:{{ .Values.network.port.api }}/v2/%(tenant_id)s' interface=public region_name={{ .Values.keystone.admin_region_name }} auth='{{ include "keystone_auth" .}}'" -e "{'openstack_nova_auth':{{ include "keystone_auth" .}}}"

ansible localhost -vvv -m kolla_keystone_user -a "project=service user={{ .Values.keystone.nova_user }} password={{ .Values.keystone.nova_password }} role=admin region_name={{ .Values.keystone.nova_region_name }} auth='{{ include "keystone_auth" .}}'" -e "{'openstack_nova_auth':{{ include "keystone_auth" .}}}"
