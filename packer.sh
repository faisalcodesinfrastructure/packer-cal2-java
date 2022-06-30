#!/bin/bash

packer_command=${packer_command:-validate}
packer_var_file=${packer_var_file:-faisal.pkrvars.hcl}

echo "INFO: Running packer ${packer_command}."

packer ${packer_command} -var-file=${packer_var_file} .