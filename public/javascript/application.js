function showHideActive(noteObject) {

    var newTitle = document.getElementById("notes-editor-content-title");
    newTitle.innerText = noteObject["title"];

    var newContent = document.getElementById("notes-editor-content-content");
    newContent.innerText = noteObject["content"];

    var editButton = document.getElementById("notes-editor-content-button");
    var newURL = `/notes/${noteObject["id"]}/edit`;
    editButton.href = newURL;
}