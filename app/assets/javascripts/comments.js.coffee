# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # Добавление формы редактирования при нажатии по ссылке
  editFormBinding = (c_id, cable_type, cable_id) ->
    $("[data-comment-form='" + c_id + "']").bind 'click', ->
      $("#comment-" + c_id).html(renderForm(c_id, cable_type, cable_id))

  renderForm = (c_id, cable_type, cable_id) ->
    commetnForm = "

      <form accept-charset='UTF-8' action='/comments/" + c_id + "' class='simple_form edit_comment' data-remote='true' id='edit_comment_" + c_id + "' method='post' novalidate='novalidate'>

      <div style='display:none'>
        <input name='utf8' value='✓' type='hidden'>
        <input name='_method' value='patch' type='hidden'>
      </div>
      <div class='form-group text required comment_body'>
        <label class='text required control-label' for='input-" + cable_type.toLowerCase + "-" + cable_id + "'>
          <abbr title='required'>*</abbr> Edit your comment
        </label>
      <div>
        <textarea class='text required form-control' id='input-" + cable_type.toLowerCase + "-" + cable_id + "' name='comment[body]'>" + $("#comment-" + c_id + "").find('div.comment_body p').text() + "</textarea>
      </div>
      </div>
      <input class='btn btn-info' name='commit' value='Update Comment' type='submit'>
    </form>

      "


  #  Обработка добавления комментариев.
  $(".comment").bind 'ajax:success', (e, data, status, xhr) ->
    json = $.parseJSON(xhr.responseText)
    form_id =  json.comment.commentable_type.toLowerCase() + "-" + json.comment.commentable_id
    $("#input-" + form_id).val('');
    $("#quantity-" + form_id ).html(json.counts + "<b class='caret'></b>");
    $("#" + form_id).append("

      <div class='comment_item' id='comment-" + json.comment.id + "'>
        <div class='comment_meta'>
          <div class='comment_author'>
            <a href='/user/" + json.user.id + "'>" + json.user.name + "</a>
          </div>
          <div class='comment_date'>
            " + json.comment.created_at + "
          </div>
          <div class='comment_tools'>

            <div class='tool'>
              <a style='cursor: pointer' data-comment-form='" + json.comment.id + "'><span class='fui-new'></span></a>
            </div>

            <div class='tool'>
              <a href='/comments/" + json.comment.id + "' data-remote='true' data-method='delete'><span class='glyphicon glyphicon-trash'></span></a>
            </div>
          </div>
        </div>
        <div class='comment_body'><p>" + json.comment.body + "</p></div>
      </div>

    ");
    editFormBinding(json.comment.id, json.comment.commentable_type, json.comment.commentable_id)
    $.jGrowl("<p>Comment was added!</p>", {theme: 'growl_notice'});
    $("[data-help-block=" + form_id + "]").remove()
    $("#input-" + form_id).parent().parent().parent().removeClass('has-error')

  .bind 'ajax:error', (e, xhr, status, error) ->
    json = $.parseJSON(xhr.responseText)
    form_id = json.commentable_type.toLowerCase() + "-" + json.commentable_id
    $("[data-help-block=" + form_id + "]").remove()
    $("#input-" + form_id)
      .parent().append("<span class='help-block' data-help-block='" + form_id + "'>" + json.errors + "</span>")
      .parent().parent().addClass('has-error')