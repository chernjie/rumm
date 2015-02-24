class MetadataController < MVCLI::Controller
  requires :compute
  requires :command

  def index
    server.metadata
  end

  def show
    server.metadata.find{|metadatum| metadatum.key == params[:id]} or fail Fog::Errors::NotFound
  end

  def create
  end

  def update
  end

  def destroy
    original = metadatum
    view = Struct.new(:key, :value).new(original.key, original.value);
    metadatum.destroy
    server.metadata.reload
    view
  end

  private

  def server
    compute.servers.find {|s| s.name == params[:server_id]} or fail Fog::Errors::NotFound
  end

  def metadatum
    server.metadata.find {|metadatum| metadatum.key == params[:id]} or fail Fog::Errors::NotFound
  end
end
