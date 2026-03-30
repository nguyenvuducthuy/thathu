# Pre-Calculus

- <p>The problem of finding the shortest distance from a point \(p(x, y)\) to the curve \(y = kx^2\)
    $$ D^2(x) = (x - px)^2 + (kx^2 - py)^2 $$
    Derivative: Take the derivative with respect to \(x\) and set it to 0 to find the minimum.
    $$2(x - px) + 2(kx^2 - py)(2kx)$$
    $$2k^2x^3 + (1 - 2kpy)x - px$$
    $$f'(x)=0 \implies 2k^2x^3 + (1 - 2kpy)x - px =0$$
    This is a depressed cubic equation of the form \(x^3 + px + q = 0\). 
    Use Cardano formula to find roots, Cardano's formula is specifically designed to solve a cubic equation that does not have an \(x^2\) term.
    $$x^3 + px + q = 0$$
    $$\text{Let: } x = u + v$$Substitution \(t\) into the function \(t^3 + Pt + Q = 0\):
    $$(u+v)^3 + P(u+v) + Q = 0$$
    $$(u^3 + v^3) + 3uv(u+v) + P(u+v) + Q = 0$$
    Reorder element:$$(u^3 + v^3 + Q) + (3uv + P)(u+v) = 0$$
    We have one equation with two unknowns (\(u\) and \(v\)), which means we have the freedom to impose a condition to make our lives easier.
    We force the second term to be zero:
    $$3uv + P = 0 \implies uv = -\frac{P}{3}$$
    This collapses the main equation into:
    $$u^3 + v^3 + Q = 0 \implies u^3 + v^3 = -Q$$
    Now we have a System of Equations:
    Sum: \(u^3 + v^3 = -Q\)
    Product: \(u^3v^3 = (-\frac{P}{3})^3 = -\frac{P^3}{27}\)
    We are looking for two numbers (\(u^3\) and \(v^3\)) where we know their Sum and their Product.
    $$z^2 - (\text{Sum})z + (\text{Product}) = 0$$
    Substitute our values:
    $$z^2 - (-Q)z + (-\frac{P^3}{27}) = 0$$
    $$z^2 + Qz - \frac{P^3}{27} = 0$$
    We solve this using the standard quadratic formula (\(\frac{-b \pm \sqrt{b^2-4ac}}{2a}\)):
    $$z = \frac{-Q \pm \sqrt{Q^2 - 4(1)(-\frac{P^3}{27})}}{2}$$
    Bring the division by 2 inside the terms:
    $$z = -\frac{Q}{2} \pm \sqrt{\frac{Q^2}{4} + \frac{P^3}{27}}$$
    These two solutions for \(z\) correspond to \(u^3\) and \(v^3\).
    The solution \(x\) is given by:
    $$x = \sqrt[3]{-\frac{q}{2} + \sqrt{\frac{q^2}{4} + \frac{p^3}{27}}} + \sqrt[3]{-\frac{q}{2} - \sqrt{\frac{q^2}{4} + \frac{p^3}{27}}}$$
    To make this easier to read and calculate, we usually break it down into steps involving the Discriminant (\(\Delta\)).
    $$\newline$$
    Step A: Calculate the Discriminant
    $$\Delta = \frac{q^2}{4} + \frac{p^3}{27}$$
    Step B: Calculate \(u\) and \(v\)
    $$u = \sqrt[3]{-\frac{q}{2} + \sqrt{\Delta}}$$$$v = \sqrt[3]{-\frac{q}{2} - \sqrt{\Delta}}$$
    Step C: The Final Root 
    $$\Delta > 0 \implies x = u + v$$
    $$\Delta <= 0 \implies x = ?$$
    </p>

- <button id="btn_001"  onclick="_updateShaderUniform(this.id)">run</button>
- <canvas id="cv_001" style="width:512px;height:512px;margin:auto;display: block;"><canvas>
