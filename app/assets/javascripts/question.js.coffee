$ ->
  PrivatePub.subscribe "/questions/357/answer", (data, channel) ->
    console.log(data)
