`timescale 1ns / 1ps

module tb_CPU();

    // Khai báo các tín hiệu giả lập
    reg clk;
    reg rst;

    // Gắn (Instantiate) module CPU_Top vào Testbench
    CPU uut (
        .clk(clk),
        .rst(rst)
    );

    // --------------------------------------------------------
    // TẠO XUNG NHỊP CLOCK (Chu kỳ 10ns -> Tần số 100MHz)
    // --------------------------------------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Đảo trạng thái mỗi 5ns
    end

    // --------------------------------------------------------
    // KỊCH BẢN MÔ PHỎNG (TEST SCENARIO)
    // --------------------------------------------------------
    initial begin
        // Khởi tạo trạng thái ban đầu
        rst = 1; 
        
        // Giữ Reset trong 20ns (2 chu kỳ clock) để hệ thống ổn định
        #20;
        
        // Nhả Reset, bắt đầu cho CPU chạy FSM
        rst = 0;

        // Chờ CPU chạy khoảng 600ns (Đủ thời gian thực thi hết 5 lệnh trên)
        #2000;

        // Kết thúc mô phỏng
        $finish;
    end

endmodule