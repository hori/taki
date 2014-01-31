#//= require underscore
#//= require backbone
$ ->

  class Similarity extends Backbone.Model

  class Similarities extends Backbone.Collection
    model:->
      Similarity

  class SimilarView extends Backbone.View
    el:->
      '#table'
    tagName:->
      'tr'
    template:->
      '<tr><td><%= current_selector_id %></td><td><%= compared_selector_id %></td><td><%= property %></td><td><%= value %></td></tr>'
    render:(args)->
      template = _.template @template()
      return @$el.append(template(args))

  class PagerView extends Backbone.View
    el:->
      '#pager'
    tagName:->
      'ul'
    template:->
      pager = '<li class="prev">前へ</li>' +
      '<li class="next">次へ</li>'
      return pager
    render:(args)->
      console.dir(args)
#      if args['total_pages']
      template = _.template @template()
      return @$el.append(template(args))

#  class NextLink extends Backbone.View
#    template:(args)->
#      if args['']

  class Router extends Backbone.Router
    initialize:->
    routes:
      '': 'index'
    index:->
      console.log('index')

  similarities = new Similarities()
  init = $.ajax({
    dataType: "json",
    type: "GET",
    data: {
      "selector_id": 1
    },
    url: "/assets/paging.json",
    success:(data)->
      new PagerView().render({current_page: data.paging.current_page, per_page: data.paging.per_page, total_pages: data.paging.total_pages})
      _.each data.similarities, (v, k)->
        similarities.add(new Similarity({current_selector_id: v.current_selector_id, compared_selector_id: v.compared_selector_id, property: v.property, value: v.value}))
  })

  $.when(init).done((data)->
    similarities.each (v) ->
      new SimilarView().render({current_selector_id: v.get('current_selector_id'), compared_selector_id: v.get('compared_selector_id'), property: v.get('property'), value: v.get('value')})
    new Router()
    Backbone.history.start()
  )