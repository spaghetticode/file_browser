require 'pry'
require 'spec_helper'

feature 'filesystem modal window', :type => :feature, :js => true do
  def modal_window
    page.find('.modal')
  end

  background do
    FsBrowser::Path.base = Rails.root.to_s
    visit '/'
    click_link 'Click me'
  end

  scenario 'shows the modal window' do
    modal_window.should have_content 'app'
    modal_window.should have_content 'lib'
  end

  scenario 'can browse the filesystem tree' do
    double_click 'lib'
    modal_window.should have_content 'assets'
  end

  scenario 'can browse the filesystem backwards' do
    double_click 'lib'
    double_click '..'
    modal_window.should_not have_content 'assets'
    modal_window.should have_content 'lib'
  end
end