if (typeof(CKEDITOR) != 'undefined') {
CKEDITOR.editorConfig = function(config) {
  config.language = 'en';
//  config.filebrowserBrowseUrl = "/ckeditor/pictures";
//  config.filebrowserFlashBrowseUrl = "/ckeditor/pictures";
//  config.filebrowserFlashUploadUrl = "/ckeditor/pictures";
//  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
//  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
//  config.filebrowserImageUploadUrl = "/ckeditor/pictures";
//  config.filebrowserUploadUrl = "/ckeditor/pictures";
  config.toolbar_Pure = [
    '/', {
      name: 'basicstyles',
      items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat']
    }, {
      name: 'paragraph',
      items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl']
    }, {
      name: 'links',
      items: ['Link', 'Unlink']
    }, '/', {
      name: 'styles',
      items: ['Styles', 'Format', 'Font', 'FontSize']
    }, {
      name: 'colors',
      items: ['TextColor', 'BGColor']
    }, {
      name: 'insert',
      items: ['Image', 'Table', 'HorizontalRule', 'PageBreak']
    }
  ];
  config.toolbar = 'Pure';
  return true;
};
}