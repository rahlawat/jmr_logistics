PDFKit.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    # config.wkhtmltopdf = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s
  end
  # config.root_url = "http://localhost:3000" unless Rails.env.staging? || Rails.env.production?
end