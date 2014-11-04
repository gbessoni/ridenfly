module ValidUserRequestHelper
  # for use in request specs
  def sign_in_as_a_valid_user
    @user ||= create :admin
    post_via_redirect user_session_path, 'user[email]' => @user.email, 'user[password]' => @user.password
  end
end
