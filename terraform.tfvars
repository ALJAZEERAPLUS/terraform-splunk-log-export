# Copyright 2021 Google LLC
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     https://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

project = "ajgc-dig-app-ops-01"
region  = "europe-west1"
create_network      = true
network             = "gcp-splunk-exporter"
subnet              = ""
primary_subnet_cidr = "10.128.0.0/24"

# Log sink details
log_filter = <<EOF
                (resource.type="cloud_run_revision"   
                resource.labels.project_id="ajgc-dig-pdi-dev-mam-0")
                OR
                (resource.type="cloud_run_revision"
                resource.labels.project_id="ajgc-dig-pdi-vidicore-exp-0")
                OR
                (resource.type="cloud_run_revision"
                resource.labels.project_id="ajgc-dig-pdi-prd-mam-0")
                OR
                (resource.type="loadbalancing.googleapis.com/InternalNetworkLoadBalancerRule"
                resource.labels.project_id="ajgc-dig-pdi-prod-mambackend-0")
                OR
                (resource.type="http_load_balancer"
                resource.labels.project_id="ajgc-tno-net-prd-hub-01"
                resource.labels.forwarding_rule_name="vidispine-prod")
                OR
                (resource.type="http_load_balancer"
                resource.labels.project_id="ajgc-tno-net-prd-hub-01"
                resource.labels.forwarding_rule_name="dev-vidispine")
                OR
                (resource.type="http_load_balancer"
                resource.labels.project_id="ajgc-tno-net-prd-hub-01"
                resource.labels.forwarding_rule_name="vidispine.stg")
                OR
                (
                resource.type="http_load_balancer"
                resource.labels.backend_service_name="mam-frontend-staging-backend"
                )
                OR
                (
                resource.type="http_load_balancer"
                resource.labels.backend_service_name="mam-frontend-prod-backend"
                )
                OR
                (
                resource.type="http_load_balancer"
                resource.labels.backend_service_name="mam-frontend-qa-backend"
                )
             EOF


# Dataflow job output
splunk_hec_url                      = "https://http-inputs.ajdigital.splunkcloud.com"
splunk_hec_token_source             = "SECRET_MANAGER"
#splunk_hec_token                    = ""
splunk_hec_token_secret_id          = "projects/773926933358/secrets/splunk_gcp_log_exporter_hec_token/versions/latest"
splunk_hec_token_kms_encryption_key = ""

# Dataflow job parameters
dataflow_worker_service_account             = "export-pipeline-worker"
use_externally_managed_dataflow_sa          = false
dataflow_job_name                           = "export-pipeline"
dataflow_job_machine_type                   = "n2-standard-2"
dataflow_job_machine_count                  = 1
dataflow_job_parallelism                    = 4
dataflow_job_batch_count                    = 10
dataflow_job_disable_certificate_validation = false
dataflow_job_udf_gcs_path                   = ""
dataflow_job_udf_function_name              = ""

# Dashboard parameters
scoping_project = "ajgc-dig-app-ops-01"

# Replay job settings
deploy_replay_job = false
