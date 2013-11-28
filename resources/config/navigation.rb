# -*- coding: utf-8 -*-
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :key_1, 'Link 1', '#'
    primary.item :key_2, 'Link 2', '#' do |sub_nav|
      sub_nav.item :key_2_1, 'Link 2 A', '#'
    end
  end
end
