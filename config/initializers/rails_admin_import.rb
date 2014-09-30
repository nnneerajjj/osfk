RailsAdminImport.config do |config|
  config.model User do
    excluded_fields do
      [
        :encrypted_password,
        :reset_password_token,
        :reset_password_sent_at,
        :remember_created_at,
        :sign_in_count,
        :current_sign_in_at,
        :last_sign_in_at,
        :current_sign_in_ip,
        :last_sign_in_ip,
        :admin,
        :website,
        :street_number,
        :notification_date,
        :house_number,
        :active,
        :water,
        :stock,
        :approved,
        :regular,
        :postal_address,
        :package1,
        :package2,
        :avatar,
        :role,
        :version,
        :topic,
        :participant,
        :event,
        :email
      ]
    end

    label :name

    extra_fields do
      [:name, :pre_email]
    end
  end
end
