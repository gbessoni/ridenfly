module RequireRole
  extend ActiveSupport::Concern

  included do
    class_attribute :roles
  end

  module ClassMethods
    def require_role(*args)
      options = args.pop if args.last.is_a?(Hash)
      add_roles(args)
      before_action(options || {}) do |controller|
        controller.send(:check_role)
      end
    end

    protected

    def add_roles(new_roles)
      self.roles ||= []
      self.roles += new_roles
      self.roles.uniq!
    end
  end

  protected

  def check_role
    ok = self.class.roles.map(&:to_s) & current_user.roles.map(&:to_s)
    unless ok.present?
      flash[:error] = "Yoy don't have permission to see this page."
      redirect_to admin_root_url
    end
  end
end
