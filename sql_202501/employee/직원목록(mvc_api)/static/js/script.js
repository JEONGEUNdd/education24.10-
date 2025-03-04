$(document).ready(function() {
    const employeeModal = new bootstrap.Modal(document.getElementById('employeeModal'));
    let currentAction = 'add';

    // 직원 목록 로드
    function loadEmployees() {
        $('.loading').show();
        $.ajax({
            url: '/api/employees',
            method: 'GET',
            success: function(response) {
                console.log(response)
                displayEmployees(response);
            },
            error: function(xhr, status, error) {
                alert('직원 목록을 불러오는데 실패했습니다.');
                console.error(error);
            },
            complete: function() {
                $('.loading').hide();
            }
        });
    }

    // 직원 목록 표시
    function displayEmployees(employees) {
        const tbody = $('#employeeList');
        tbody.empty();

        employees.forEach(function(emp) {
            // const row = '<td>' + emp.id + '</td>';
            // $("#name").text(emp.name);
            // const row = '';
            //       row += '';
            const row = `
                <tr>
                    <td>${emp.id}</td>
                    <td>${emp.name}</td>
                    <td>${emp.email}</td>
                    <td>${emp.department}</td>
                    <td>${Number(emp.salary).toLocaleString()}원</td>
                    <!--td>${emp.hire_date}</td-->
                    <td>${dayjs(emp.hire_date).format('YYYY-MM-DD')}</td>
                    <td class="action-buttons">
                        <button class="btn btn-sm btn-primary edit-btn" data-id="${emp.id}">
                            <i class="bi bi-pencil"></i>
                        </button>
                        <button class="btn btn-sm btn-danger delete-btn" data-id="${emp.id}">
                            <i class="bi bi-trash"></i>
                        </button>
                    </td>
                </tr>
            `;
            tbody.append(row);
        });
    }

    // 폼 초기화
    function resetForm() {
        $('#employeeForm')[0].reset();
        $('#employeeId').val('');
        $('.error-message').hide();
    }

    // 직원 추가 버튼 클릭
    $('#addEmployeeBtn').click(function() {
        currentAction = 'add';
        resetForm();
        $('.modal-title').text('직원 추가');
        employeeModal.show();
    });

    // 직원 수정 버튼 클릭
    $(document).on('click', '.edit-btn', function() {
        currentAction = 'edit';
        const id = $(this).data('id');
        $('.loading').show();

        $.ajax({
            url: `/api/employees/${id}`,
            method: 'GET',
            success: function(employee) {
                $('#employeeId').val(employee.id);
                $('#name').val(employee.name);
                $('#email').val(employee.email);
                $('#department').val(employee.department);
                $('#salary').val(employee.salary);
                //let hire_date = dayjs(employee.hire_date).format('YYYY-MM-DD HH:mm:ss')
                let hire_date = dayjs(employee.hire_date).format('YYYY-MM-DD')
                $('#hireDate').val(hire_date);
                
                $('.modal-title').text('직원 정보 수정');
                employeeModal.show();
            },
            error: function(xhr, status, error) {
                alert('직원 정보를 불러오는데 실패했습니다.');
                console.error(error);
            },
            complete: function() {
                $('.loading').hide();
            }
        });
    });

    // 직원 저장
    $('#saveEmployee').click(function() {
        const employeeData = {
            name: $('#name').val(),
            email: $('#email').val(),
            department: $('#department').val(),
            salary: $('#salary').val(),
            hire_date: $('#hireDate').val()
        };

        const id = $('#employeeId').val();
        const url = currentAction === 'add' ? '/api/employees' : `/api/employees/${id}`;
        const method = currentAction === 'add' ? 'POST' : 'PUT';

        $('.loading').show();
        $.ajax({
            url: url,
            method: method,
            contentType: 'application/json',
            data: JSON.stringify(employeeData),
            success: function(response) {
                employeeModal.hide();
                loadEmployees();
                alert(currentAction === 'add' ? '직원이 추가되었습니다.' : '직원 정보가 수정되었습니다.');
            },
            error: function(xhr, status, error) {
                const errors = xhr.responseJSON?.errors || {};
                Object.keys(errors).forEach(field => {
                    $(`#${field}Error`).text(errors[field]).show();
                });
            },
            complete: function() {
                $('.loading').hide();
            }
        });
    });

    // 직원 삭제
    $(document).on('click', '.delete-btn', function() {
        if (!confirm('정말 이 직원을 삭제하시겠습니까?')) return;

        const id = $(this).data('id');
        $('.loading').show();

        $.ajax({
            url: `/api/employees/${id}`,
            method: 'DELETE',
            success: function() {
                loadEmployees();
                alert('직원이 삭제되었습니다.');
            },
            error: function(xhr, status, error) {
                alert('직원 삭제에 실패했습니다.');
                console.error(error);
            },
            complete: function() {
                $('.loading').hide();
            }
        });
    });

    // 검색 기능
    $('#searchInput').on('keyup', function() {
        const searchText = $(this).val().toLowerCase();
        $('#employeeList tr').filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(searchText) > -1);
        });
    });

    // 부서 필터링
    $('#departmentFilter').change(function() {
        const department = $(this).val();
        if (department) {
            $('#employeeList tr').filter(function() {
                $(this).toggle($(this).children('td:eq(3)').text() === department);
            });
        } else {
            $('#employeeList tr').show();
        }
    });

    // 초기 로드
    loadEmployees();
});