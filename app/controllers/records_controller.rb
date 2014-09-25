class RecordsController < MVCLI::Controller
  requires :domains
  requires :command

  def index
    domain.records.all
  end

  def create
    template = Records::CreateForm
    argv = MVCLI::Argv.new command.argv
    form = template.new argv.options
    form.validate!

    options = {
      name: form.name,
      type: form.type,
      value: form.data,
      ttl: form.ttl,
      priority: form.priority
    }

    domain.records.create options
  end

  def show
    record
  end

  def update
    template = Records::UpdateForm
    argv = MVCLI::Argv.new command.argv
    form = template.new argv.options
    form.validate!

    unupdated_record = record

    unupdated_record.name = form.name if form.name
    unupdated_record.type = form.type if form.type
    unupdated_record.value = form.data if form.data
    unupdated_record.ttl = form.ttl if form.ttl
    unupdated_record.priority = form.priority if form.priority

    unupdated_record.save
  end

  def destroy
    record.tap do |r|
      r.destroy
    end
  end

  private

  def domain
    domains.find { |d| d.domain == params["domain_id"] } or fail Fog::Errors::NotFound
  end

  def record
    domain.records.find { |r| r.id == params["id"] } or fail Fog::Errors::NotFound
  end
end
