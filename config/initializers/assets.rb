# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( audio.js )
Rails.application.config.assets.precompile += %w( browser.js )
Rails.application.config.assets.precompile += %w( bulk.js )
Rails.application.config.assets.precompile += %w( cable.js )
Rails.application.config.assets.precompile += %w( date.js )
Rails.application.config.assets.precompile += %w( delete_selected.js )
Rails.application.config.assets.precompile += %w( dropdown.js )
Rails.application.config.assets.precompile += %w( load.js )
Rails.application.config.assets.precompile += %w( locale.js )
Rails.application.config.assets.precompile += %w( tag.js )
Rails.application.config.assets.precompile += %w( tabs.js )
Rails.application.config.assets.precompile += %w( channels/* )