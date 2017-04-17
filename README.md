# Luzifer / project-status

This repository contains a template for a SVG image to be embedded into the README file of a Github repository. Doing so allows to display and update the project status of that repository without doing an extra commit. As soon as the image is update in S3 Github will re-fetch it after some time and visitors are noticed about the status of the project.

Example:

![project status](https://d2o84fseuhwkxk.cloudfront.net/project-status.svg)

## Usage

```bash
# vault2env secret/aws/private -- make active PROJECT_NAME="project-status"
test "project-status" != ""
test "active" != ""
korvike -i template.svg | aws s3 cp \
        --acl=public-read \
        --content-type=image/svg+xml \
        - s3://io.luzifer.status/project-status.svg
echo "" | aws s3 cp \
        --acl=public-read \
        --website-redirect=https://badges.fyi/static/Project%20Status/In%20active%20development/0d0 \
        - s3://io.luzifer.status/project-status_badge.svg
```
