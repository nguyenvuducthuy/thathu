<style>
table {
    width: 100%;
}
/* Đã làm đẹp lại phần UI điều khiển */
.math-container { font-family: sans-serif; max-width: 600px; margin: auto; }
.controls { margin-top: 15px; padding: 15px; background: #f8f9fa; border-radius: 8px; border: 1px solid #ddd; }
.stats { display: flex; justify-content: space-between; margin-top: 10px; font-size: 1.1rem; }
input[type=range] { width: 100%; cursor: pointer; }
.formula { font-size: 1.5rem; margin: 15px 0; color: #222; text-align: center; }
</style>

# Calculus

## Trực quan hóa Đạo hàm $\( \frac{dy}{dx} \)$
$$ \frac{dy}{dx} = \lim_{\Delta x \to 0} \frac{f(x + \Delta x) - f(x)}{\Delta x} $$

## Trực quan hóa Tích phân $\int x^2 dx$ bằng Tổng Riemann
Diện tích thực tế dưới đường cong được định nghĩa là giới hạn của tổng diện tích các hình chữ nhật (Tổng Riemann) khi số lượng hình chữ nhật ($n$) tiến tới vô cực:
$$\int_{a}^{b} f(x) dx = \lim_{n \to \infty} \sum_{i=1}^{n} f(x_i^*) \Delta x$$

<hr style="margin: 30px 0; border: 1px solid #eee;">

## Định lý Cơ bản của Giải tích (Sir Isaac Newton)

Trước thế kỷ 17, các nhà toán học coi việc tìm độ dốc (tiếp tuyến) và tính diện tích dưới đường cong là hai bài toán hoàn toàn khác biệt. Phải đến khi **Isaac Newton** (và Gottfried Leibniz) xuất hiện, họ mới phát hiện ra một sự thật chấn động: **Hai phép toán này thực chất là nghịch đảo của nhau!**

Định lý này được chia làm hai phần quan trọng:

### Phần 1: Đạo hàm và Tích phân là hai phép toán ngược

Nếu bạn có một hàm số liên tục $f(t)$ và bạn lấy diện tích tích lũy của nó từ mốc $a$ đến $x$, rồi đem đi tính đạo hàm... bạn sẽ quay về đúng hàm số ban đầu!

$$\frac{d}{dx} \left( \int_{a}^{x} f(t) dt \right) = f(x)$$

> **💡 Hiểu đơn giản:** Tích phân giống như hành động "bấm nút ghi hình" để tích lũy quãng đường, còn đạo hàm là hành động "tua ngược" để trả về vận tốc tức thời lúc ban đầu.

### Phần 2: Công thức Newton-Leibniz (Phép màu tính toán)

Nhờ định lý này, chúng ta **không cần phải cắt nhỏ diện tích thành hàng triệu hình chữ nhật Riemann** để tính tổng cực nhọc nữa. Thay vào đó, để tính diện tích dưới đường cong $f(x)$ từ $a$ đến $b$, ta chỉ cần tìm nguyên hàm $F(x)$ của nó:

$$\int_{a}^{b} f(x) dx = F(b) - F(a)$$

**Ví dụ thực tế:** Để tính diện tích dưới Parabol $f(x) = x^2$ từ $x=1$ đến $x=2$:
1. Tìm nguyên hàm: $F(x) = \frac{1}{3}x^3$
2. Lấy điểm cuối trừ điểm đầu: $F(2) - F(1) = \frac{1}{3}(2)^3 - \frac{1}{3}(1)^3 = \frac{8}{3} - \frac{1}{3} = \frac{7}{3}$

**Kết quả:** Diện tích chính xác tuyệt đối là $\approx 2.333$, giải quyết xong chỉ trong 2 dòng tính toán tay!

<button id="btn_derivative"  onclick="_loadCalculusLesson(this.id)">Derivative</button>
<button id="btn_integrals"  onclick="_loadCalculusLesson(this.id)">Integrals</button>
<div id="local-ggb-element" style="width=100%"></div>

<!---->
<!-- | preview | code | -->
<!-- |---|---| -->
<!-- |<canvas id="cv_001" style="width:512px;height:512px;"><canvas> | <div><div id="monaco-safe-zone"></div><button id="btn_001"  onclick="_updateShaderUniform(this.id)">run</button></div>| -->
