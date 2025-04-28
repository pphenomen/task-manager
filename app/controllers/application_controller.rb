class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from ActiveRecord::ConnectionNotEstablished, with: :handle_db_connection_error
  rescue_from ActiveRecord::StatementInvalid, with: :handle_db_statement_error
  rescue_from ActiveRecord::RecordNotDestroyed, with: :handle_record_not_destroyed

  PER_PAGE = 5

  def paginate(scope)
    page = (params[:page] || 1).to_i
    total_pages = (scope.count.to_f / PER_PAGE).ceil
    paginated_scope = scope.offset((page - 1) * PER_PAGE).limit(PER_PAGE)

    {
      records: paginated_scope,
      current_page: page,
      total_pages: total_pages
    }
  end

  private

  def handle_record_not_destroyed(exception)
    Rails.logger.error "Ошибка удаления записи: #{exception.record.errors.full_messages.to_sentence}"
    redirect_back fallback_location: root_path, alert: exception.record.errors.full_messages.to_sentence
  end

  def handle_db_connection_error(exception)
    Rails.logger.error "Ошибка подключения к базе данных: #{exception.message}"
    render plain: "Сервис временно недоступен. Попробуйте позже.", status: :service_unavailable
  end

  def handle_db_statement_error(exception)
    Rails.logger.error "Ошибка выполнения SQL-запроса: #{exception.message}"
    render plain: "Ошибка базы данных.", status: :internal_server_error
  end
end
