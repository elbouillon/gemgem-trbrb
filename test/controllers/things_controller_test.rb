require 'test_helper'
require 'capybara'

describe ThingsController do
  let (:thing) { Thing::Create[thing: {name: "Trailblazer"}].model }

  describe "#new" do
    it "#new [HTML]" do
      get :new

      page.must_have_css "form #thing_name"

      assert_select "form #thing_name"
      assert_select "form #thing_name.readonly", false
    end
  end

  describe "#create" do
    it do
      post :create, {thing: {name: "Bad Religion"}}
      assert_redirected_to thing_path(Thing.last)
    end

    it do # invalid.
      post :create, {thing: {name: ""}}
      assert_select ".error"
    end
  end

  describe "#edit" do
    it do
      get :edit, id: thing.id
      assert_select "form #thing_name.readonly[value='Trailblazer']"
    end
  end

  describe "#update" do
    it do
      put :update, id: thing.id, thing: {name: "Trb"}
      assert_redirected_to thing_path(thing)
      # assert_select "h1", "Trb"
    end

    it do
      put :update, id: thing.id, thing: {description: "bla"}
      assert_select ".error"
    end
  end

  describe "#show" do
    it "HTML" do
      get :show, id: thing.id
      response.body.must_match /Trailblazer/
    end
  end
end