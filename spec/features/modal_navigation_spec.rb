require 'pry'
require 'spec_helper'

feature 'filesystem modal window', :type => :feature, :js => true do
  def modal_window
    page.find('.modal')
  end

  background do
    FsBrowser::Path.base = Rails.root.join('spec/fixtures/filesystem/').to_s
    visit '/'
    click_link 'Click me'
  end

  scenario 'shows the modal window' do
    modal_window.should have_content 'folder'
    modal_window.should have_content 'file.txt'
  end

  scenario 'can browse the filesystem tree' do
    double_click 'folder'
    modal_window.should have_content 'example.txt'
  end

  scenario 'can browse the filesystem backwards' do
    double_click 'folder'
    double_click '..'
    modal_window.should_not have_content 'example.txt'
    modal_window.should have_content 'file.txt'
  end
end