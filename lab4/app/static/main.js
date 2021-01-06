$('#delete-user-modal').on('show.bs.modal', function (event) {
    let url = event.relatedTarget.dataset.url; //берём из кнопки data-url
    let form = this.querySelector('form'); // обращаемся к форме внутри модалки
    form.action = url;
    let userName = event.relatedTarget.closest('tr').querySelector('.user-name').textContent; // берём объект кнопки, находим строку таблицы, в которой она находится. по классу 'user-name' берём ФИО пользователя.
    this.querySelector('#user-name').textContent = userName; // подставляем ФИО в спан, который находится в вопросе об удалении
})