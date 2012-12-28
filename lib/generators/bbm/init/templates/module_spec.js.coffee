describe "<%= app_name %> <%= module_namespace %> suite", ->
  module = <%= app_name %>.<%= module_namespace %>
  
  it "initialize module namespace", ->
    expect(module).toEqual(jasmine.any(Object))

  it "should containe common objects", ->
    expect(module.Views).toEqual(jasmine.any(Object))
    expect(module.Models).toEqual(jasmine.any(Object))
    expect(module.Collections).toEqual(jasmine.any(Object))
    