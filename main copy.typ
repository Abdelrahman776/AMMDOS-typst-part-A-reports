#import "@preview/barcala:0.2.0": apendice, informe, nomenclatura
#import "@preview/lilaq:0.5.0" as lq // Paquete para gráficos, puede ser omitido
#import "@preview/physica:0.9.6": * // Paquete para matemática y física, puede ser omitido
#import "@preview/zero:0.5.0" // Paquete para números lindos y unidades de medida, puede ser omitido

#show: informe.with(
  unidad-academica: "ingeniería",
  asignatura: "",
  trabajo: "ADVANCED METHODS OF MONITORING AND DESIGN OF SYSTEMS",
  equipo: "Group 22",
  autores: (
    (
      nombre: "Abdelrahman , Elsharkawy",
      email: "s8220949@studenti.unige.it",
      legajo: "S8220949",
      
    ),
    (
      nombre: "Abbas, alloul",
      email: "s4712172@studenti.unige.it",
      legajo: "S4712172",
    ),
    (
      nombre: "Eman , Sadig",      email: "s6864398@studenti.unige.it",      legajo: "S6864398",
    ),
  ),

  titulo: [Assignment #2 on Uncertainty Quantification
Response Surface Method & Sensitivity Analysis 
],
  // resumen: [*_Objetivo_ --- determinación de las constantes de tiempo ($tau$) de carga y descarga de un circuito RC. Análisis de la dependencia de $tau$ en función de los valores de resistencia y capacidad que conforman el circuito.*],


)

// Configuración de `zero`
#import zero: num, zi
#zero.set-num(
  decimal-separator: ",",
)
#zero.set-group(
  size: 3,
  separator: ".",
  threshold: (integer: 5, fractional: calc.inf),
)
#zero.set-unit(
  fraction: "inline",
)

// Bloques de matemática con números para citar
#set math.equation(numbering: "(1)")

// Unidades
#let Vm = zi.declare("V/m")


=  Sensitivity analysis
<objective>
The goal of this exercise is to determine how each input variable of the heat exchanger model influences the output quantity Q (heat transferred between the two fluids). The analysis is performed at the nominal operating point, applying a ±1% perturbation to each input one at a time while keeping the others fixed. The resulting output variation is used to compute a non-dimensional sensitivity coefficient for each input. This allows ranking of the input parameters according to their influence on system performance.

== Model Description <model-description>
The heat exchanger is modeled using the NTU using HeatExchanger2025.m and effectiveness.m. The relationship between heat transfer and system parameters is given by:


Q = ε · C_min · (T_hot,in - T_cold,in)


where C = m\_dot \* c\_p is the heat-capacity rate \[W/K\], C\_min and C\_max are the minimum and maximum heat-capacity rates, and ε is the heat-exchanger effectiveness depending on NTU, Cr, and exchanger type.

For Group 22, the parameters are as follows:

#figure(
  align(
    center,
  )[#table(
      columns: (46.86%, 14.82%, 23.69%, 14.62%), align: (center, center, center, center,), table.header(
        table.cell(align: center)[Parameter], table.cell(align: center)[Symbol], table.cell(align: center)[Value], table.cell(align: center)[Unit],
      ), table.hline(), table.cell(align: center)[Overall heat transfer coefficient], table.cell(align: center)[U], table.cell(align: center)[2.0 × 10⁴], table.cell(align: center)[W/m²·K], table.cell(align: center)[Heat exchange area], table.cell(align: center)[A], table.cell(align: center)[10], table.cell(align: center)[m²], table.cell(align: center)[Specific heat (hot fluid, air)], table.cell(align: center)[c\_p,hot], table.cell(align: center)[1.005 × 10³], table.cell(align: center)[J/kg·K], table.cell(align: center)[Specific heat (cold fluid, water)], table.cell(align: center)[c\_p,cold], table.cell(align: center)[4.180 × 10³], table.cell(align: center)[J/kg·K], table.cell(align: center)[Heat exchanger type], table.cell(align: center)[—], table.cell(align: center)[One Shell Pass], table.cell(align: center)[—],
    )], kind: table,
)

The nominal operating point for Group 22 is defined as follows:

#figure(
  align(
    center,
  )[#table(
      columns: (44.99%, 18.09%, 26.74%, 10.18%), align: (center, center, center, center,), table.header(
        table.cell(align: center)[Input], table.cell(align: center)[Symbol], table.cell(align: center)[Nominal Value], table.cell(align: center)[Unit],
      ), table.hline(), table.cell(align: center)[Hot mass flow rate], table.cell(align: center)[ṁ\_hot], table.cell(align: center)[561], table.cell(align: center)[kg/s], table.cell(align: center)[Cold mass flow rate], table.cell(align: center)[ṁ\_cold], table.cell(align: center)[137], table.cell(align: center)[kg/s], table.cell(align: center)[Hot-side inlet temperature], table.cell(align: center)[T\_hot,in], table.cell(align: center)[548], table.cell(align: center)[K], table.cell(align: center)[Cold-side inlet temperature], table.cell(align: center)[T\_cold,in], table.cell(align: center)[317], table.cell(align: center)[K],
    )], kind: table,
)

The output of interest is the total heat transferred, Q \[W\].

== Mathematical Formulation <mathematical-formulation>
The non-dimensional sensitivity coefficient for each input variable x\_i is defined as:

$ S_i = ((Delta Q / Q) / (Delta x_i / x_i)) = (x_i / Q) dot (partial Q / partial x_i) $

It quantifies the percentage change in Q resulting from a 1% change in each input x\_i. Since analytical derivatives are unavailable, finite differences are used:

$ (partial Q) / (partial x_i) approx [Q(x_i + Delta x_i) - Q(x_i - Delta x_i)] / (2 Delta x_i) $

== MATLAB Implementation <matlab-implementation>
\
#figure(image("media/image1.png", height: 4.7in, ))
\

The MATLAB implementation follows the same structure as the RSA.m script from class but calls the HeatExchanger2025 model. A 1% perturbation is applied to each input, and the output sensitivities are computed using central finite differences.

== Interpretation of Results <interpretation-of-results>
Running the MATLAB script produces a bar chart showing the relative magnitude and sign of each non-dimensional sensitivity. #figure(image("media/image2.png", height: 3.3916666666666666in, width: 6.0in))

Typical results and physical interpretations are summarized below:

#figure(
  align(
    center,
  )[#table(
      columns: (10.59%, 6.09%, 17.73%, 65.59%), align: (center, center, center, center,), table.header(
        table.cell(align: center)[Input], table.cell(align: center)[Sign], table.cell(align: center)[Relative Magnitude], table.cell(align: center)[Physical Interpretation],
      ), table.hline(), table.cell(align: center)[ṁ\_hot], table.cell(align: center)[+], table.cell(align: center)[Medium], table.cell(
        align: center,
      )[Increasing hot flow rate increases heat-capacity rate and total heat transfer.], table.cell(align: center)[ṁ\_cold], table.cell(align: center)[+], table.cell(align: center)[Small], table.cell(
        align: center,
      )[Larger cold-side flow increases C\_cold but has a minor influence since C\_hot is limiting.], table.cell(align: center)[T\_hot,in], table.cell(align: center)[+], table.cell(align: center)[Largest], table.cell(
        align: center,
      )[Hotter inlet increases temperature difference, raising Q.], table.cell(align: center)[T\_cold,in], table.cell(align: center)[−], table.cell(align: center)[Second largest], table.cell(
        align: center,
      )[Warmer cold inlet decreases the temperature difference, reducing Q.],
    )], kind: table,
)

Thus, the heat transfer rate Q is most sensitive to the inlet temperatures, particularly T\_hot,in, while mass-flow variations have smaller but positive effects. The negative sensitivity of T\_cold,in confirms its inverse relationship with heat transfer.

== conclusion <conclusion>
The results clearly indicate that the overall performance of the heat exchanger is mainly governed by the temperature difference between the hot and cold fluids. Maintaining a high hot-side inlet temperature and a low cold-side inlet temperature will yield higher Q values. The mass flow rates influence the heat capacity ratio and NTU, but their effect on Q remains secondary compared to the inlet temperatures.The signs of the sensitivities are physically consistent and in agreement with thermodynamic expectations. All sensitivities are dimensionless, allowing a direct ranking of input importance. 
\

= Generate input data
The purpose of this exercise is to generate a set of input data for the heat-exchanger simulation according to a Design of Experiments (DoE) technique (Full F).

== What is a Design of Experiments (DoE)? <what-is-a-design-of-experiments-doe>
A Design of Experiments (DoE) is a structured statistical approach used to plan numerical or physical experiments efficiently. Instead of testing inputs randomly, DoE defines combinations of variables (factors) at specific values (levels) so that the influence of each factor can be studied systematically, interactions between factors can be detected, and the number of required simulations is minimized while maintaining accuracy. Each row in the DoE table represents a single simulation or \'experimental run\'.

== Selected DoE Method for Group 22 <selected-doe-method-for-group-22>
According to the assignment table, Group 22 must apply the Full Factorial (FF) DoE method with three levels per variable. A Full Factorial design tests all possible combinations of levels for the selected factors. Since each factor has 3 levels and three variables are considered, the total number of runs is 3^3 = 27. This design ensures a complete exploration of the input space. \
\
The relevant parameters for Group 22 are summarized below:

#figure(
  align(
    center,
  )[#table(
      columns: (24.45%, 10.74%, 10.37%, 9.88%, 27.32%, 6.49%, 10.75%), align: (center, center, center, center, center, center, center,), table.header(
        table.cell(align: center)[Input Variable], table.cell(align: center)[Symbol], table.cell(align: center)[Nominal], table.cell(align: center)[± Range], table.cell(align: center)[Levels (Low / Mid / High)], table.cell(align: center)[Unit], table.cell(align: center)[Varies?],
      ), table.hline(), table.cell(align: center)[Hot mass-flow rate], table.cell(align: center)[ṁ\_hot], table.cell(align: center)[561], table.cell(align: center)[±18], table.cell(align: center)[\[543, 561, 579\]], table.cell(align: center)[kg/s], table.cell(align: center)[Yes], table.cell(align: center)[Hot-inlet temperature], table.cell(align: center)[T\_hot,in], table.cell(align: center)[548], table.cell(align: center)[±39], table.cell(align: center)[\[509, 548, 587\]], table.cell(align: center)[K], table.cell(align: center)[Yes], table.cell(align: center)[Cold-inlet temperature], table.cell(align: center)[T\_cold,in], table.cell(align: center)[317], table.cell(align: center)[±14], table.cell(align: center)[\[303, 317, 331\]], table.cell(align: center)[K], table.cell(align: center)[Yes], table.cell(align: center)[Cold mass-flow rate], table.cell(align: center)[ṁ\_cold], table.cell(align: center)[137], table.cell(align: center)[0], table.cell(align: center)[\[137\]], table.cell(align: center)[kg/s], table.cell(align: center)[Constant],
    )], kind: table,
)

== MATLAB Implementation <matlab-implementation-1>
The DoE was implemented in MATLAB using the built-in function fullfact, which generates all level combinations for the selected factors. The following script defines the three factors with their corresponding levels and creates the full factorial matrix consisting of 27 runs. The constant cold mass-flow rate was added as an additional column.

 #figure(image("media/image3.png", height: 3.9381944444444446in, width: 6.0in))

#figure(
   image("media/image4.png", height: 3.9881944444444444in),
)

Executing the MATLAB script produces a 27×4 table of input combinations. Each row represents one simulation run defined by unique values of the hot and cold mass flow rates and inlet temperatures. The cold mass-flow rate remains constant across all runs.

== Interpretation
The generated 27 input combinations systematically cover all possible low, medium, and high values of the three input variables. This Full Factorial design guarantees a complete coverage of the input space.


= Generate output data  according to the DoE method
The objective of this exercise is to generate the output data of the heat exchanger by evaluating the MATLAB simulation model for all input combinations obtained from the Full Factorial Design of Experiments (DoE) developed in Exercise 2. For each input set, the heat-transfer rate Q is computed and recorded.

== Concept and Methodology <concept-and-methodology>
From Exercise 2, a Full Factorial DoE with 27 input combinations was generated. Each design point corresponds to a unique set of values for the hot and cold fluid mass-flow rates and inlet temperatures. The present task involves using these input combinations as inputs to the provided MATLAB heat exchanger model (HeatExchanger2025.m). The model computes the total heat-transfer rate Q and outlet temperatures of both fluids. The results are then stored in a single table combining inputs and outputs.

== Model Information <model-information>
The model HeatExchanger2025.m implements the NTU–effectiveness method, while the function effectiveness.m is called internally to calculate the effectiveness ε. For Group 22, the parameters used in the simulation are listed below:

#figure(
  align(
    center,
  )[#table(
      columns: (50.58%, 34.37%, 15.04%), align: (center, center, center,), table.header(
        table.cell(align: center)[Parameter], table.cell(align: center)[Symbol / Value], table.cell(align: center)[Unit],
      ), table.hline(), table.cell(align: center)[Overall heat-transfer coefficient], table.cell(align: center)[U = 20 × 10³], table.cell(align: center)[W/m²·K], table.cell(align: center)[Heat-exchange area], table.cell(align: center)[A = 10], table.cell(align: center)[m²], table.cell(align: center)[Specific heat of hot fluid (air)], table.cell(align: center)[c\_p,hot = 1.005 × 10³], table.cell(align: center)[J/kg·K], table.cell(align: center)[Specific heat of cold fluid (water)], table.cell(align: center)[c\_p,cold = 4.180 × 10³], table.cell(align: center)[J/kg·K], table.cell(align: center)[Heat exchanger type], table.cell(align: center)[One Shell Pass], table.cell(align: center)[—],
    )], kind: table,
)


== MATLAB Implementation <matlab-implementation-2>
The MATLAB script below follows the same logic as the cantilever exercise presented in class. For each DoE input set, the function HeatExchanger2025 is called to compute the corresponding heat-transfer rate Q. The resulting data are stored in a single table.#figure(
   image(
      "media/image5.png", height: 4in, fit: "stretch"
   ),
)

== Results <results>
Executing the script yields a table containing 27 rows (corresponding to each DoE combination) and five columns (the four input variables plus the output Q). An example of the output table format is shown below (values are illustrative):

#figure(
   image(
      "media/image6.png", height: 4.5174989063867015in, 
   ),
)

== Comments <comments>
The results demonstrate that the heat-transfer rate Q increases when the hot-side inlet temperature or mass flow rate increases, as both lead to higher available energy and greater temperature difference. Conversely, higher cold-side inlet temperatures result in lower Q values. These outcomes are consistent with the expected thermodynamic behavior of the heat exchanger. The resulting dataset will be used in Exercise 4 to develop the Response Surface Model (RSM).

= RSM

<exercise-4-response-surface-modeling-rsm>
The data generated in Exercise 3 (Table X) were saved as a MATLAB file (\`DoE\_OUT.mat\`) containing the 27 design points and their corresponding heat-transfer rates (Q). These data were then used in Exercise 4 to construct response-surface models of different polynomial orders. Since the cold-side mass-flow rate (ṁ\_cold = 137 kg/s) was constant across all runs, it was excluded from the regression to avoid rank-deficiency and ensure numerical stability. The response surfaces were therefore expressed as Q = f(ṁ\_hot, T\_hot,in, T\_cold,in).

== objective <objective-1>
The objective of this exercise is to fit the output data obtained from Exercise 3 with multiple Response Surface Models (RSM) of increasing complexity—linear, bilinear, and quadratic. Each model form is fitted using MATLAB’s \`polyfitn\` function, and its performance is evaluated using the coefficient of determination (R²). The symbolic form of each model is obtained using \`polyn2sympoly\` when the Sympoly toolbox is available.

== Methodology <methodology>
The dataset containing the input and output variables was loaded from the file \`DoE\_OUT.mat\`. Since ṁ\_cold was constant, it was omitted from the fitting process. The remaining variables (ṁ\_hot, T\_hot,in, and T\_cold,in) were used as predictors for the heat-transfer rate Q. Three models were then fitted using the \`polyfitn\` function:

• Linear: first-order polynomial terms only. \
• Bilinear: first-order terms and all pairwise interaction terms. \
• Quadratic: includes first-order, interaction, and squared terms.

== MATLAB Implementation <matlab-implementation-3>
 The following MATLAB script illustrates the full fitting process for Group 22, using the data saved from Exercise 3. The script computes and compares R² values for linear, bilinear, and quadratic models.
 
 #figure(image("media/image7.png", height: 7in, width: 6.0in))


== Results and Interpretation <results-and-interpretation>
 #figure(image("media/image8.png", ))
 
 After fitting the models, MATLAB displays the coefficients, R² values, and (if available) symbolic expressions of each fitted surface. The resulting R² values typically increase with model complexity, as higher-order polynomials capture nonlinear behavior. 
 \
 #figure(image("media/image9.png",width: 8in, ))

#figure(
   image(
      "media/image10.png", height: 2.3881944444444443in, width: 3.6819444444444445in,
   ),
)

== Discussion \
The linear model provided an excellent first-order approximation of the system’s behavior, while the bilinear model further improved the fit by including cross-interaction terms. The quadratic model achieved the highest accuracy (R² close to 1), indicating that the system response exhibits mild nonlinearities. Warnings about matrix conditioning were noted but did not affect the accuracy of the results. Therefore, the quadratic response surface is selected as the most accurate representation of the system’s output.


= Response Surface Visualization <exercise-5-response-surface-visualization>
== Objective <objective-2>
#figure(
   image(
      "media/image11.png", height: 7.011111111111111in, width: 4.673611111111111in,
   ),
)The objective of this exercise is to visualize the most accurate Response Surface Model (RSM) identified in Exercise 4 and analyze how the heat-transfer rate (Q) varies with respect to the system’s input parameters. The visualization is performed by plotting three 3D surfaces that show Q as a function of two varying inputs while keeping the third at its nominal value.

== Methodology <methodology-1>
According to the results of Exercise 4, the Quadratic RSM was selected as the most accurate model for Group 22. This model expresses the heat-transfer rate Q as a function of the three varying inputs: ṁ\_hot, T\_hot,in, and T\_cold,in. The cold-side mass-flow rate ṁ\_cold is constant at 137 kg/s and was excluded from the regression. Using MATLAB, three 3D surfaces were plotted by varying two variables at a time and fixing the third at its nominal value.

== MATLAB Implementation <matlab-implementation-4>
The MATLAB script below was used to generate the three response-surface plots for the Quadratic model. Each plot visualizes how Q changes with two varying inputs, while keeping the third input constant at its nominal value


== Results <results-1>
The three generated plots illustrate the influence of the input parameters on the heat-transfer rate Q as predicted by the Quadratic model. Each surface corresponds to a pair of varying inputs with the remaining variable fixed at its nominal value.



#figure(
   image(
      "media/image12.png", height: 3.2763134295713034in, width: 5.223529090113736in,
   ),caption: [Q = f(ṁ\_hot, T\_hot,in) | T\_cold,in = 317 K — Both increasing hot mass flow rate and inlet temperature increase Q, as they raise the available heat capacity and the driving temperature difference.]
)

\

#figure(
   image(
      "media/image13.png", height: 3.209902668416448in, width: 5.117646544181977in,
   ),caption: [Q = f(T\_hot,in, T\_cold,in) | ṁ\_hot = 561 kg/s — Q increases with T\_hot,in and decreases with T\_cold,in, confirming that the temperature difference between streams governs heat transfer.]
)

\


 #figure(
   image(
      "media/image14.png", height: 3.317361111111111in, width: 5.288888888888889in,
   ),caption: [Q = f(ṁ\_hot, T\_cold,in) | T\_hot,in = 548 K — Q increases with ṁ\_hot and decreases with T\_cold,in; the curved surface indicates weak interaction between flow and temperature effects.]
) 

== Discussion <discussion>
The response surfaces derived from the selected Quadratic model show physically consistent behavior. The heat-transfer rate rises with increasing hot-side mass flow rate and inlet temperature and decreases with higher cold-inlet temperature. These results align with the fundamental heat exchanger theory, which states that heat transfer depends on the product of the heat capacity rate and the temperature difference between the two fluids. The smooth curvature of the surfaces confirms that the Quadratic model accurately captures the nonlinear interactions among the system variables.
