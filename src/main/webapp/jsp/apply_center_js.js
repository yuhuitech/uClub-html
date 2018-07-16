    var remarkShowLength = 3;//默认现实的字符串长度


    function reloadCreateApplyTableData(newDataSet) {
        var currentPage = manageCreateApplyTable.page();
        manageCreateApplyTable.clear();
        manageCreateApplyTable.rows.add(newDataSet);
        manageCreateApplyTable.page(currentPage).draw(false);
    }

// manageCreateApply表 begins!
    var manageCreateApplyTable;

    var editingID;
    var tempid;

    function initCreateApplyTable(status, dataSet) {
        manageCreateApplyTable = $("#manageCreateApply-table").DataTable({
        "sZeroRecords": "没有检索到数据",
        // "sProcessing": "<img src='./loading.gif' />",加载中的动画效果
        "bStateSave": true,
        "bInfo": true,//页脚信息
        "bAutoWidth": true,//自动宽度
        "deferRender": true,//当处理大数据时，延迟渲染数据，有效提高Datatables处理能力
        // pageLength: 4,//显示个数table
        data:dataSet,
        columns: [
            {
                "sTitle": "申请ID",
                "sClass": "hiddenCol"
            },
            {
                title: "社团名称"
            },
            {
                title: "社团类型"
            },
            {
                title: "简介"
            },
            {
                title: "申请人学号"
            },
            {
                title: "申请人姓名"
            },
            {
                title: "社团规模"
            },
            {
                title: "申请时间"
            }],
        "columnDefs": [
            {
                type : "string",
                targets : 0,
            },
            {
                type : "string",
                targets : [1],

            },
            {
                type : "string",
                targets : [2],

            },
            {
                type : "string",
                targets : [3],
                "render": function (data, type, row, meta) {
                    if (row[3].length > remarkShowLength+10) {
                        return row[3].substring(0,remarkShowLength+10)+"...";//显示部分信息
                    } else {
                        return row[3];//显示原始全部信息 }
                    }
                }
            },
            {
                type : "string",
                targets : [4],
            },
            {
                type : "string",
                targets : [5],
            },
            {
                type : "date",
                targets : [6],
            }
        ],
        "order": [[7, 'asc']],
        "oLanguage": {
            "sLengthMenu": "每页显示 _MENU_ 条记录",
            "sZeroRecords": "没有检索到数据",
            "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
            "sInfoEmpty": "没有数据",
            "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
            "sSearch": "搜索",
            "oPaginate": {
                "sFirst": "首页",
                "sPrevious": "前一页",
                "sNext": "后一页",
                "sLast": "尾页"
            }
        },
        dom: "Blfrtip",
        buttons: [
            {
                text:'拷贝',
                extend: "copy",
                className: "btn-sm"
            },
            {
                extend: "csv",
                className: "btn-sm",
                text:'csv表格',
            },

            {
                extend: "excel",
                className: "btn-sm",
                text:'excel',
                filename:"",
                customize: function ( xlsx ) {
                    var sheet = xlsx.xl.worksheets['sheet1.xml'];
                    $('c[r=A1] t', sheet).text( '结果' );
                    $('c[c=A1] t', sheet).text( '' );
                }
            },
            {
                extend: "pdf",
                className: "btn-sm",
                text:'pdf',
            },
            {
                extend: "print",
                className: "btn-sm",
                text:'打印',
            },
        ],
        responsive: true
    });

        $('#manageCreateApply-table tbody').on('click', 'tr', function () {

        });

        $('#manageCreateApply-table tbody').on('click', 'tr', function () {
            selectedRol = this;
            alert(this.cells[0].innerText);
            $('#editCreateApplyTableDetail').modal('show');
            editingID = this.cells[0].innerText;//利用selectedRol向弹出的模态框提交数据，修改结果
            //document.getElementById("clubNameInCreateApplyTable").value = this.cell[1].innerText;
            $("#clubNameInCreateApplyTable").val(this.cells[1].innerText);
            $("#clubTypeInCreateApplyTable").val(this.cells[2].innerText);
            $("#clubInfoInCreateApplyTable").val(this.cells[3].innerText);
            $("#stuNoInCreateApplyTable").val(this.cells[4].innerText);
            $("#stuNameInCreateApplyTable").val(this.cells[5].innerText);
            $("#clubSizeInCreateApplyTable").val(this.cells[6].innerText);
            $("#applyTimeInCreateApplyTable").val(this.cells[7].innerText);

        });
}

/////////////////////////////////////////////////////////////////////////

    function reloadAllClubTableData(newDataSet) {
        var currentPage = manageAllClubTable.page();
        manageAllClubTable.clear();
        manageAllClubTable.rows.add(newDataSet);
        manageAllClubTable.page(currentPage).draw(false);
    }

    // manageCreateApply表 begins!
    var manageAllClubTable;

    // var editingID;

    function initAllClubTable(status, dataSet) {
        manageAllClubTable = $("#manageAllClub-table").DataTable({
            "sZeroRecords": "没有检索到数据",
            "bStateSave": true,
            "bInfo": true,//页脚信息
            "bAutoWidth": true,//自动宽度
            "deferRender": true,//当处理大数据时，延迟渲染数据，有效提高Datatables处理能力
            // pageLength: 4,//显示个数table
            data:dataSet,
            columns: [
                {
                    "sTitle": "社团ID",
                    "sClass": "hiddenCol"
                },
                {
                    title: "社团名称"
                },
                {
                    title: "社团类型"
                },
                {
                    title: "简介"
                }],
            "columnDefs": [
                {
                    type : "string",
                    targets : 0,
                },
                {
                    type : "string",
                    targets : [1],

                },
                {
                    type : "string",
                    targets : [2],

                },
                {
                    type : "string",
                    targets : [3],

                }
                // {
                //     type : "string",
                //     targets : [4],
                //     "render": function (data, type, row, meta) {
                //         if (row[1].length > remarkShowLength) {
                //             return row[1].substring(0,remarkShowLength)+"...";//显示部分信息
                //         } else {
                //             return row[1];//显示原始全部信息 }
                //         }
                //     }
                // }
            ],
            "order": [[1, 'asc']],
            "oLanguage": {
                "sLengthMenu": "每页显示 _MENU_ 条记录",
                "sZeroRecords": "没有检索到数据",
                "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
                "sInfoEmpty": "没有数据",
                "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
                "sSearch": "搜索",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"
                }
            },
            dom: "Blfrtip",
            buttons: [
                {
                    text:'拷贝',
                    extend: "copy",
                    className: "btn-sm"
                },
                {
                    extend: "csv",
                    className: "btn-sm",
                    text:'csv表格',
                },

                {
                    extend: "excel",
                    className: "btn-sm",
                    text:'excel',
                    filename:"",
                    customize: function ( xlsx ) {
                        var sheet = xlsx.xl.worksheets['sheet1.xml'];
                        $('c[r=A1] t', sheet).text( '结果' );
                        $('c[c=A1] t', sheet).text( '' );
                    }
                },
                {
                    extend: "pdf",
                    className: "btn-sm",
                    text:'pdf',
                },
                {
                    extend: "print",
                    className: "btn-sm",
                    text:'打印',
                },
            ],
            responsive: true
        });

        $('#manageAllClub-table tbody').on('click', 'tr', function () {

        });

        $('#manageAllClub-table tbody').on('click', 'tr', function () {
            selectedRol = this;
            alert(this.cells[0].innerText);
            $('#editAllClubTableDetail').modal('show');
            // $('#editAllClubTableDetail');//利用selectedRol向弹出的模态框提交数据，修改结果
            editingID = this.cells[0].innerText;

        });
    }

    /////////////////////////////////////////////////////////////////////////

    function reloadMoneyApplyTableData(newDataSet) {
        var currentPage = manageMoneyApplyTable.page();
        manageMoneyApplyTable.clear();
        manageMoneyApplyTable.rows.add(newDataSet);
        manageMoneyApplyTable.page(currentPage).draw(false);
    }

    // manageCreateApply表 begins!
    var manageMoneyApplyTable;

    // var editingID;

    function initMoneyApplyTable(status, dataSet) {
        manageMoneyApplyTable = $("#manageFundApply-table").DataTable({
            "sZeroRecords": "没有检索到数据",
            "bStateSave": true,
            "bInfo": true,//页脚信息
            "bAutoWidth": true,//自动宽度
            "deferRender": true,//当处理大数据时，延迟渲染数据，有效提高Datatables处理能力
            // pageLength: 4,//显示个数table
            data:dataSet,
            columns: [
                {
                    "sTitle": "申请ID",
                    "sClass": "hiddenCol"
                },

                {
                    title: "活动名称"
                },
                {
                    title: "社团名称"
                },
                {
                    title: "申请资金"
                },
                {
                    title: "申请理由"
                }],
            "columnDefs": [
                {
                    type : "string",
                    targets : 0,
                },

                {
                    type : "string",
                    targets : [1],

                },
                {
                    type : "string",
                    targets : [2],

                },
                {
                    type : "string",
                    targets : [3],

                },

                {
                    type : "string",
                    targets : [4],
                    "render": function (data, type, row, meta) {
                        if (row[4].length > 10) {
                            return row[4].substring(0,remarkShowLength)+"...";//显示部分信息
                        } else {
                            return row[4];//显示原始全部信息 }
                        }
                    }
                }
            ],
            "oLanguage": {
                "sLengthMenu": "每页显示 _MENU_ 条记录",
                "sZeroRecords": "没有检索到数据",
                "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
                "sInfoEmpty": "没有数据",
                "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
                "sSearch": "搜索",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"
                }
            },
            dom: "Blfrtip",
            buttons: [
                {
                    text:'拷贝',
                    extend: "copy",
                    className: "btn-sm"
                },
                {
                    extend: "csv",
                    className: "btn-sm",
                    text:'csv表格',
                },

                {
                    extend: "excel",
                    className: "btn-sm",
                    text:'excel',
                    filename:"",
                    customize: function ( xlsx ) {
                        var sheet = xlsx.xl.worksheets['sheet1.xml'];
                        $('c[r=A1] t', sheet).text( '结果' );
                        $('c[c=A1] t', sheet).text( '' );
                    }
                },
                {
                    extend: "pdf",
                    className: "btn-sm",
                    text:'pdf',
                },
                {
                    extend: "print",
                    className: "btn-sm",
                    text:'打印',
                },
            ],
            responsive: true
        });

        $('#manageFundApply-table tbody').on('click', 'tr', function () {

        });

        $('#manageFundApply-table tbody').on('click', 'tr', function () {
            selectedRol = this;
            alert(this.cells[0].innerText);
            $('#editFundApplyTableDetail').modal('show');
            // $('#editAllClubTableDetail');//利用selectedRol向弹出的模态框提交数据，修改结果
            editingID = this.cells[0].innerText;
            $("#activityNameInFundApplyTable").val(this.cells[1].innerText);
            $("#clubNameInFundApplyTable").val(this.cells[2].innerText);
            $("#amountInFundApplyTable").val(this.cells[3].innerText);
            $("#applyReasonInFundApplyTable").val(this.cells[4].innerText);

        });
    }




//////管理社团创建历史的表
    /////////////////////////////////////////////////////////////////////////

    function reloadCreationHistoryTableData(newDataSet) {
        var currentPage = manageCreationHistoryTable.page();
        manageCreationHistoryTable.clear();
        manageCreationHistoryTable.rows.add(newDataSet);
        manageCreationHistoryTable.page(currentPage).draw(false);
    }

    // manageCreateApply表 begins!
    var manageCreationHistoryTable;

    // var editingID;

    function initCreationHistoryTable(status, dataSet) {
        manageCreationHistoryTable = $("#manageCreationHistory-table").DataTable({
            "sZeroRecords": "没有检索到数据",
            "bStateSave": true,
            "bInfo": true,//页脚信息
            "bAutoWidth": true,//自动宽度
            "deferRender": true,//当处理大数据时，延迟渲染数据，有效提高Datatables处理能力
            // pageLength: 4,//显示个数table
            data:dataSet,
            columns: [
                {
                    "sTitle": "申请ID",
                    "sClass": "hiddenCol"
                },
                {
                    title: "社团名称"
                },
                {
                    title: "社团类型"
                },
                {
                    title: "简介"
                },
                {
                    title: "申请人学号"
                },
                {
                    title: "申请人姓名"
                },
                {
                    title: "社团规模"
                },
                {
                    title: "申请时间"
                }],
            "columnDefs": [
                {
                    type : "string",
                    targets : 0,
                },
                {
                    type : "string",
                    targets : [1],

                },
                {
                    type : "string",
                    targets : [2],

                },
                {
                    type : "string",
                    targets : [3],
                    "render": function (data, type, row, meta) {
                        if (row[3].length > remarkShowLength+10) {
                            return row[3].substring(0,remarkShowLength+10)+"...";//显示部分信息
                        } else {
                            return row[3];//显示原始全部信息 }
                        }
                    }
                },
                {
                    type : "string",
                    targets : [4],
                },
                {
                    type : "string",
                    targets : [5],
                },
                {
                    type : "date",
                    targets : [6],
                },
                {
                    type : "date",
                    targets : [7],
                }
            ],
            "oLanguage": {
                "sLengthMenu": "每页显示 _MENU_ 条记录",
                "sZeroRecords": "没有检索到数据",
                "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
                "sInfoEmpty": "没有数据",
                "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
                "sSearch": "搜索",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"
                }
            },
            dom: "Blfrtip",
            buttons: [
                {
                    text:'拷贝',
                    extend: "copy",
                    className: "btn-sm"
                },
                {
                    extend: "csv",
                    className: "btn-sm",
                    text:'csv表格',
                },

                {
                    extend: "excel",
                    className: "btn-sm",
                    text:'excel',
                    filename:"",
                    customize: function ( xlsx ) {
                        var sheet = xlsx.xl.worksheets['sheet1.xml'];
                        $('c[r=A1] t', sheet).text( '结果' );
                        $('c[c=A1] t', sheet).text( '' );
                    }
                },
                {
                    extend: "pdf",
                    className: "btn-sm",
                    text:'pdf',
                },
                {
                    extend: "print",
                    className: "btn-sm",
                    text:'打印',
                },
            ],
            responsive: true
        });

        $('#manageCreationHistory-table tbody').on('click', 'tr', function () {

        });

        $('#manageCreationHistory-table tbody').on('click', 'tr', function () {
            selectedRol = this;
            alert(this.cells[0].innerText);
            $('#editCreationHistoryTableDetail').modal('show');
            // $('#editAllClubTableDetail');//利用selectedRol向弹出的模态框提交数据，修改结果
            editingID = this.cells[0].innerText;
            $("#clubNameInCreationHistoryTable").val(this.cells[1].innerText);
            $("#clubTypeInCreationHistoryTable").val(this.cells[2].innerText);
            $("#clubInfoInCreationHistoryTable").val(this.cells[3].innerText);
            $("#stuNoInCreationHistoryTable").val(this.cells[4].innerText);
            $("#stuNameInCreationHistoryTable").val(this.cells[5].innerText);
            $("#clubSizeInCreationHistoryTable").val(this.cells[6].innerText);
            $("#applyTimeInCreationHistoryTable").val(this.cells[7].innerText);

        });
    }

    //////管理社团解散历史的表
    /////////////////////////////////////////////////////////////////////////

    function reloadClubDissolveApplyTableData(newDataSet) {
        var currentPage = manageClubDissolveApplyTable.page();
        manageClubDissolveApplyTable.clear();
        manageClubDissolveApplyTable.rows.add(newDataSet);
        manageClubDissolveApplyTable.page(currentPage).draw(false);
    }

    // manageCreateApply表 begins!
    var manageClubDissolveApplyTable;

    // var editingID;

    function initClubDissolveApplyTable(status, dataSet) {
        manageClubDissolveApplyTable = $("#manageClubDissolveApply-table").DataTable({
            "sZeroRecords": "没有检索到数据",
            "bStateSave": true,
            "bInfo": true,//页脚信息
            "bAutoWidth": true,//自动宽度
            "deferRender": true,//当处理大数据时，延迟渲染数据，有效提高Datatables处理能力
            // pageLength: 4,//显示个数table
            data:dataSet,
            columns: [
                {
                    "sTitle": "申请ID",
                    "sClass": "hiddenCol"
                },
                {
                    "sTitle": "社团ID",
                    "sClass": "hiddenCol"
                },
                {
                    title: "社团名称"
                },
                {
                    title: "管理员学号"
                },
                {
                    title: "管理员姓名"
                },
                {
                    title: "解散原因"
                },],
            "columnDefs": [
                {
                    type : "string",
                    targets : 0,
                },
                {
                    type : "string",
                    targets : 1,
                },
                {
                    type : "string",
                    targets : [2],

                },
                {
                    type : "string",
                    targets : [3],

                },

                {
                    type : "string",
                    targets : [4],
                },
                {
                    type : "string",
                    targets : [5],
                    "render": function (data, type, row, meta) {
                        if (row[5].length > remarkShowLength+10) {
                            return row[5].substring(0,remarkShowLength+10)+"...";//显示部分信息
                        } else {
                            return row[5];//显示原始全部信息 }
                        }
                    }
                }
            ],
            "oLanguage": {
                "sLengthMenu": "每页显示 _MENU_ 条记录",
                "sZeroRecords": "没有检索到数据",
                "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
                "sInfoEmpty": "没有数据",
                "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
                "sSearch": "搜索",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"
                }
            },
            dom: "Blfrtip",
            buttons: [
                {
                    text:'拷贝',
                    extend: "copy",
                    className: "btn-sm"
                },
                {
                    extend: "csv",
                    className: "btn-sm",
                    text:'csv表格',
                },

                {
                    extend: "excel",
                    className: "btn-sm",
                    text:'excel',
                    filename:"",
                    customize: function ( xlsx ) {
                        var sheet = xlsx.xl.worksheets['sheet1.xml'];
                        $('c[r=A1] t', sheet).text( '结果' );
                        $('c[c=A1] t', sheet).text( '' );
                    }
                },
                {
                    extend: "pdf",
                    className: "btn-sm",
                    text:'pdf',
                },
                {
                    extend: "print",
                    className: "btn-sm",
                    text:'打印',
                },
            ],
            responsive: true
        });

        $('#manageClubDissolveApply-table tbody').on('click', 'tr', function () {

        });

        $('#manageClubDissolveApply-table tbody').on('click', 'tr', function () {
            selectedRol = this;
            alert(this.cells[0].innerText);
            $('#editClubDissolveApplyTableDetail').modal('show');
            // $('#editAllClubTableDetail');//利用selectedRol向弹出的模态框提交数据，修改结果
            editingID = this.cells[0].innerText;
            tempid = this.cells[1].innerText;
            $("#clubNameInClubDissolveApplyTable").val(this.cells[2].innerText);
            $("#stuIDInClubDissolveApplyTable").val(this.cells[3].innerText);
            $("#stuNameInClubDissolveApplyTable").val(this.cells[4].innerText);
            $("#reasonInClubDissolveApplyTable").val(this.cells[5].innerText);

        });
    }


    //////管理资金申请历史的表
    /////////////////////////////////////////////////////////////////////////

    function reloadHistoryFundApplyTableData(newDataSet) {
        var currentPage = manageHistoryFundApplyTable.page();
        manageHistoryFundApplyTable.clear();
        manageHistoryFundApplyTable.rows.add(newDataSet);
        manageHistoryFundApplyTable.page(currentPage).draw(false);
    }

    // manageCreateApply表 begins!
    var manageHistoryFundApplyTable;

    // var editingID;

    function initHistoryFundApplyTable(status, dataSet) {
        manageHistoryFundApplyTable = $("#manageHistoryFundApply-table").DataTable({
            "sZeroRecords": "没有检索到数据",
            "bStateSave": true,
            "bInfo": true,//页脚信息
            "bAutoWidth": true,//自动宽度
            "deferRender": true,//当处理大数据时，延迟渲染数据，有效提高Datatables处理能力
            // pageLength: 4,//显示个数table
            data:dataSet,
            columns: [
                {
                    "sTitle": "申请ID",
                    "sClass": "hiddenCol"
                },
                {
                    title: "活动名称"
                },
                {
                    title: "社团名称"
                },
                {
                    title: "申请资金"
                },
                {
                    title: "申请理由"
                }],
            "columnDefs": [
                {
                    type : "string",
                    targets : 0,
                },
                {
                    type : "string",
                    targets : [1],

                },
                {
                    type : "string",
                    targets : [2],

                },
                {
                    type : "string",
                    targets : [3],

                },
                {
                    type : "string",
                    targets : [4],
                    "render": function (data, type, row, meta) {
                        if (row[4].length > 20) {
                            return row[4].substring(0,remarkShowLength+10)+"...";//显示部分信息
                        } else {
                            return row[4];//显示原始全部信息 }
                        }
                    }
                }
            ],
            "oLanguage": {
                "sLengthMenu": "每页显示 _MENU_ 条记录",
                "sZeroRecords": "没有检索到数据",
                "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
                "sInfoEmpty": "没有数据",
                "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
                "sSearch": "搜索",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"
                }
            },
            dom: "Blfrtip",
            buttons: [
                {
                    text:'拷贝',
                    extend: "copy",
                    className: "btn-sm"
                },
                {
                    extend: "csv",
                    className: "btn-sm",
                    text:'csv表格',
                },

                {
                    extend: "excel",
                    className: "btn-sm",
                    text:'excel',
                    filename:"",
                    customize: function ( xlsx ) {
                        var sheet = xlsx.xl.worksheets['sheet1.xml'];
                        $('c[r=A1] t', sheet).text( '结果' );
                        $('c[c=A1] t', sheet).text( '' );
                    }
                },
                {
                    extend: "pdf",
                    className: "btn-sm",
                    text:'pdf',
                },
                {
                    extend: "print",
                    className: "btn-sm",
                    text:'打印',
                },
            ],
            responsive: true
        });

        $('#manageHistoryFundApply-table tbody').on('click', 'tr', function () {

        });

        $('#manageHistoryFundApply-table tbody').on('click', 'tr', function () {
            selectedRol = this;
            alert(this.cells[0].innerText);
            $('#editHistoryFundApplyTableDetail').modal('show');
            // $('#editAllClubTableDetail');//利用selectedRol向弹出的模态框提交数据，修改结果
            editingID = this.cells[0].innerText;
            $("#activityNameInHistoryFundApplyTable").val(this.cells[1].innerText);
            $("#clubNameInHistoryFundApplyTable").val(this.cells[2].innerText);
            $("#amountInHistoryFundApplyTable").val(this.cells[3].innerText);
            $("#applyReasonInHistoryFundApplyTable").val(this.cells[4].innerText);
        });
    }


    // // manageCreateApply表 begins!
// var manageAllClubTable =  $("#manageAllClub-table").DataTable({
//     "sZeroRecords": "没有检索到数据",
//     // "sProcessing": "<img src='./loading.gif' />",加载中的动画效果
//     "bStateSave": true,
//     "bInfo": true,//页脚信息
//     // "bAutoWidth": true,//自动宽度
//     "deferRender": true,//当处理大数据时，延迟渲染数据，有效提高Datatables处理能力
//     columns: [
//         {
//             "data": "ApplyNo",
//             "sTitle": "申请ID",
//             "sClass": "hiddenCol"
//         },
//         {
//             data: "ClubName",
//             title: "社团名称"
//         },
//         {
//             data: "ClubType",
//             title: "社团类型"
//         },
//         {
//             data: "ClubInfo",
//             title: "简介"
//         },
//         {
//             data: "StuNo",
//             title: "申请人学号"
//         },
//         {
//             data: "StuName",
//             title: "上岗时间"
//         },
//         {
//             data: "ClubSize",
//             title: "社团规模"
//         },
//         {
//             data: "ApplyTime",
//             title: "申请时间"
//         }],
//     "columnDefs": [
//         {
//             type : "string",
//             targets : [0],
//         },
//         {
//             type : "string",
//             targets : [1],
//         },
//         {
//             type : "string",
//             targets : [2],
//
//         },
//         {
//             type : "string",
//             targets : [3],
//             "render": function (data, type, row, meta) {
//                 if (row.ClubInfo.length > remarkShowLength) {
//                     return row.ClubInfo.substring(0,remarkShowLength)+"...";//显示部分信息
//                 } else {
//                     return row.ClubInfo;//显示原始全部信息 }
//                 }
//             }
//
//         },
//         {
//             type : "string",
//             targets : [4],
//         },
//         {
//             type : "string",
//             targets : [5],
//         },
//         {
//             type : "date",
//             targets : [6],
//         }
//     ],
//     "order": [[6, 'asc']],
//     "oLanguage": {
//         "sLengthMenu": "每页显示 _MENU_ 条记录",
//         "sZeroRecords": "没有检索到数据",
//         "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
//         "sInfoEmpty": "没有数据",
//         "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
//         "sSearch": "搜索",
//         "oPaginate": {
//             "sFirst": "首页",
//             "sPrevious": "前一页",
//             "sNext": "后一页",
//             "sLast": "尾页"
//         }
//     },
//     dom: "Blfrtip",
//     buttons: [
//         {
//             text:'拷贝',
//             extend: "copy",
//             className: "btn-sm"
//         },
//         {
//             extend: "csv",
//             className: "btn-sm",
//             text:'csv表格',
//         },
//
//         {
//             extend: "excel",
//             className: "btn-sm",
//             text:'excel',
//             filename:"",
//             customize: function ( xlsx ) {
//                 var sheet = xlsx.xl.worksheets['sheet1.xml'];
//                 $('c[r=A1] t', sheet).text( '结果' );
//                 $('c[c=A1] t', sheet).text( '' );
//             }
//         },
//         {
//             extend: "pdf",
//             className: "btn-sm",
//             text:'pdf',
//         },
//         {
//             extend: "print",
//             className: "btn-sm",
//             text:'打印',
//         },
//     ],
//     responsive: true
// });
//
// $('#manageAllClub-table tbody').on('click', 'tr', function () {
//     selectedRol = this;
//     alert(this.cells[0].innerText);
//     $('#editAllClubTableDetail').modal('show');
// });


// $(document).on('show.bs.modal', '.modal', function(event) {
//     $(this).appendTo($('body'));
// }).on('shown.bs.modal', '.modal.in', function(event) {
//     setModalsAndBackdropsOrder();
// }).on('hidden.bs.modal', '.modal', function(event) {
//     setModalsAndBackdropsOrder();
// });
//
//
// function setModalsAndBackdropsOrder() {
//     var modalZIndex = 1040;
//     $('.modal.in').each(function(index) {
//         var $modal = $(this);
//         modalZIndex++;
//         $modal.css('zIndex', modalZIndex);
//         $modal.next('.modal-backdrop.in').addClass('hidden').css('zIndex', modalZIndex - 1);
//     });
//     $('.modal.in:visible:last').focus().next('.modal-backdrop.in').removeClass('hidden');
// }

window.onload = function() {
        initCreateApplyTable();
        initAllClubTable();
        initMoneyApplyTable();
        initCreationHistoryTable();
        initClubDissolveApplyTable();
        initHistoryFundApplyTable();
        $('.modal').on('hide.bs.modal', function() {
            $("body").removeClass('modal-open');
            $("body").css('padding-right', '0px');
        });
};