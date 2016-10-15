class Service
  def perform!
    perform_action
  end

  def initialize(*)
    @errors = []
  end

  # override
  def perform_action
    raise NotImplementedError
  end

  def status
    @status ||= false
  end

  def succeed!
    @status = true
  end

  def fail!
    @status = false
  end

  def errors
    @errors&.join(', ') || ''
  end

  def succeed?
    @status == true
  end

  def failed?
    !succeed?
  end
end
