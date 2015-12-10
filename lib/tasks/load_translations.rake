namespace :data do
  task :load_translations, [:locale] => [:environment] do |t, args|
    locale = args['locale']
    file = [locale, 'yml'].join('.')
    translations = YAML.load_file(Rails.root.join('config/locales', file))[locale]

    I18n.backend.store_translations(locale, translations, :escape => false)
  end
end
