BUCKET=io.luzifer.status

active: export STATUS=active
active: publish

bugsonly: export STATUS=bugsonly
bugsonly: publish

unmaintained: export STATUS=unmaintained
unmaintained: publish

publish: testenv_PROJECT_NAME testenv_STATUS
	korvike -i template.svg | aws s3 cp \
		--acl=public-read \
		--content-type=image/svg+xml \
		- s3://$(BUCKET)/$(PROJECT_NAME).svg
	echo "" | aws s3 cp \
		--acl=public-read \
		--website-redirect=$(shell STATUS=$(STATUS) korvike -i template_badge.url) \
		- s3://$(BUCKET)/$(PROJECT_NAME)_badge.svg

# Target to ensure the required environment variables are not empty
testenv_%:
	test "$($*)" != ""

