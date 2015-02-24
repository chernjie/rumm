class MetadataController < MVCLI::Controller
  requires :compute
  requires :command

  def index
    metadata
  end

  def show
    metadatum
  end

  def create
    template = Metadata::CreateForm
    argv = MVCLI::Argv.new command.argv
    form = template.new argv.options
    form.validate!

    return_data = Struct.new(:key, :value, :server).new(form.key, form.value, server);

    metadata[form.key] = form.value unless form.value == nil or form.key == nil
    metadata.save
    metadata.reload
    return_data
  end

  def update
    template = Metadata::UpdateForm
    argv = MVCLI::Argv.new command.argv
    form = template.new argv.options
    form.validate!

    original = metadatum
    return_data = Struct.new(:key, :value, :server, :original_value).new(original.key, form.value, server, original.value);

    metadata[original.key] = form.value unless form.value == nil or form.value == original.value
    metadata.save
    metadata.reload
    return_data
  end

  def destroy
    original = metadatum
    return_data = Struct.new(:key, :value).new(original.key, original.value);
    metadatum.destroy
    metadata.reload
    return_data
  end

  private

  def server
    compute.servers.find {|s| s.name == params[:server_id]} or fail Fog::Errors::NotFound
  end

  def metadata
    server.metadata
  end

  def metadatum
    metadata.find {|metadatum| metadatum.key == params[:id]} or fail Fog::Errors::NotFound
  end
end
