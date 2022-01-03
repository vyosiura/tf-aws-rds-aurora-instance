# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [v0.2.0] - 2022-01-03

### Added
- Changelog file to keep track of this module changes
- Example directory to make it easy to use this module

### Changed
- Now supports Terraform >= v0.13, < v2.0.0 
- Provider AWS support: >= 3.41.0, < 4.0.0
- Provider Random support: >= 3.1.0, < 4.0.0

### Fixed
- Required variables are now required:
    - Variable `cluster_identifier`, `engine`, `engine_version`, `db_subnet_group_name`, `parameter_group_family`, `parameter_group_name` is now required

### Removed
- Removed DNS record creation in Route53
    - Variables removed: `record_name`, `record_type`, `zone_id`, `record_ttl`
    - Resources removed: `aws_route53_record.aurora`
- Removed the variable `instance_scope` and its usage throughout the module


