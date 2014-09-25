class DomainsController < MVCLI::Controller
  requires :domains
  requires :command

  def index
    domains.all
  end

  def create
    template = Domains::CreateForm
    argv = MVCLI::Argv.new command.argv
    form = template.new argv.options
    form.validate!

    options = {
      domain: form.name,
      email: form.email
    }

    domains.create options
  end

  def show
    domain
  end

  def update
    template = Domains::UpdateForm
    argv = MVCLI::Argv.new command.argv
    form = template.new argv.options
    form.validate!

    unupdated_domain = domain
    unupdated_domain.domain = form.name if form.name
    unupdated_domain.email  = form.email if form.email
    unupdated_domain.ttl    = form.ttl if form.ttl

    unupdated_domain.save
  end

  def destroy
    domain.tap do |d|
      d.destroy
    end
  end

  private

  def domain
    domains.find { |d| d.domain == params["id"] } or fail Fog::Errors::NotFound
  end
end
