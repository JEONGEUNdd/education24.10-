$.ajax({
    url: '/api/data',
    method: 'GET',
    dataType: 'json',
    success: function(data) {
        const dataDiv = $('#data'); // jQuery 선택자 사용
        dataDiv.html(`<p>${data.message}</p><ul>${data.items.map(item => `<li>${item}</li>`).join('')}</ul>`);
    },
    error: function(xhr, status, error) {
        console.error('Error fetching data:', error);
    }
});

