build_layers: clean_layers layer_pgdump layer_awscli
	@echo "layers built !!"

layer_pgdump:
	@zip -yr9 exports/layer_pgdump.zip layers/postgres 

layer_awscli:
	@bash layers/awscli/generator.sh ${PWD}/exports/layer_awscli.zip

clean_layers:
	rm -rf exports/*

deploy_function:
	@rm -rf export
	@mkdir -p export
	@zip -ry export/layer.zip bootstrap bin
