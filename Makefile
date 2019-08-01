build_bin:
	sh layer_zen.sh

clean_bin:
	rm -rf bin/slacktee

build:
	@rm -rf export
	@mkdir -p export
	@zip -ry export/layer.zip bootstrap bin
