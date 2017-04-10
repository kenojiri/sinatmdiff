function reload(before, after){
  var url = '/list/' + before + '/' + after + '/html';
  if( before * after == 0 ) {
    url = '/list/html';
  }
  $.ajax({
    url: url,
    type: 'GET',
    success: function(result){
      var jqo = $(result);
      $('tbody#list').replaceWith(jqo);
      var numofmds = jqo.children('.mdiff-tr').length;
      if( numofmds > 1 ) {
        var newafter = $('tr.mdiff-after').attr('id');
        var newbefore = $('tr.mdiff-before').attr('id');
        $('div#diff').load('/diff/' + newbefore + '/' + newafter + '/html');
      } else {
        $('div#diff').html('too few markdowns : ' + numofmds);
      }
    }
  });
}

$('button#new').click(function(){
  var markdown = $('textarea#newmarkdown').val();
  $.ajax({
    url: '/markdown',
    type: 'POST',
    data: { "markdown": markdown },
    success: function(result){
      reload(0, 0);
      $('textarea#newmarkdown').val("");
    }
  });
});

$(document).on('click', 'button.mdiff-select-before', function(){
  var after = $('tr.mdiff-after').attr('id');
  var itemid = $(this).attr('id');
  if(after > 0) {
    reload(itemid, after);
  }
});

$(document).on('click', 'button.mdiff-select-after', function(){
  var before = $('tr.mdiff-before').attr('id');
  var itemid = $(this).attr('id');
  if(before > 0) {
    reload(before, itemid);
  }
});

$(document).on('click', 'button.mdiff-preview', function(){
  var itemid = $(this).attr('id');
  $('#preview-modal div#preview').load('/markdown/' + itemid + '/html');
});

$(document).on('click', 'button.mdiff-edit', function(){
  var itemid = $(this).attr('id');
  $('button.mdiff-edit-confirm').attr('id', itemid);
  $('textarea#editmarkdown').load('/markdown/' + itemid + '/raw');
});

$('button.mdiff-edit-confirm').click(function(){
  var itemid = $(this).attr('id');
  var markdown = $('textarea#editmarkdown').val();
  $.ajax({
    url: '/markdown/' + itemid,
    type: 'PUT',
    data: { "markdown": markdown },
  });
  var after = $('tr.mdiff-after').attr('id');
  var before = $('tr.mdiff-before').attr('id');
  reload(before, after);
  $('textarea#editmarkdown').val("");
});

$(document).on('click', 'button.mdiff-delete', function(){
  var itemid = $(this).attr('id');
  $('a.mdiff-delete-confirm').attr('id', itemid);
  $.ajax({
    url: '/markdown/' + itemid + '/date',
    type: 'GET',
    success: function(result){
      $('#delete-modal .modal-body>p').html(result);
    }
  });
});

$('a.mdiff-delete-confirm').click(function(){
  $.ajax({
    url: '/markdown/' + $(this).attr('id'),
    type: 'DELETE',
  });
  reload(0, 0);
});

$(function(){
  reload(0, 0);
});
