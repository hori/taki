window.Taki =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize:->
    new Taki.Routers.Similarity
    Backbone.history.start()


$(document).ready ->

  console.log(Taki);
  Taki.initialize()
  init = $.ajax({
    dataType: "json",
    type: "GET",
    data: {
      "selector_id": 1
    },
    url: "/assets/paging.json",
    success:(data)->
      console.dir(data)
      pager = new Taki.Views.Pager(collection: @collection)
      pager.render({current_page: data.paging.current_page, per_page: data.paging.per_page, total_pages: data.paging.total_pages})
      _.each data.collection, (v, k)->
        @collection.add(new Similarity({current_selector_id: v.current_selector_id, compared_selector_id: v.compared_selector_id, property: v.property, value: v.value}))
  })

  $.when(init).done((data)->
    console.log('collection create done')
    similarities.each (v) ->
      new SimilarView().render({current_selector_id: v.get('current_selector_id'), compared_selector_id: v.get('compared_selector_id'), property: v.get('property'), value: v.get('value')})
  )
 