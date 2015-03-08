if (typeof(CKEDITOR) != 'undefined') {
CKEDITOR.editorConfig = function(config) {
  config.language = 'en';
  config.height = "600";
  config.width = "1100";
  config.fontSize_defaultLabel = '14px'
  config.allowedContent = true;
  config.disableNativeSpellChecker = false;
  //config.extra_plugins = 'youtube';
  //config.filebrowserBrowseUrl = '/fileman/index.html';
  config.filebrowserBrowseUrl = "/ckeditor/pictures";
  config.filebrowserFlashBrowseUrl = "/ckeditor/pictures";
  config.filebrowserFlashUploadUrl = "/ckeditor/pictures";
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
  //config.filebrowserImageBrowseUrl = "/fileman/index.html?type=image";
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";
  config.filebrowserUploadUrl = "/ckeditor/pictures";
  //config.removeDialogTabs = 'link:upload;image:Upload';
  config.toolbar_Pure = [
    '/', {
      name: 'basicstyles',
      items: ['Source', 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat']
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
