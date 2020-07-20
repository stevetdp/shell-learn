## FaaS on Storage

1. [Data-Driven Serverless Functions for Object Storage]()
   
   + 在对象存储数据路径上提供无服务器函数功能
   + Interception layer
   + Computation Layer
   
2. [An Investigation Of The Impact Of Language Runtime On The Performance And Cost Of Serverless Functions](http://faculty.washington.edu/wlloyd/courses/tcss562/papers/Fall2019/Group10-AnInvestigationOfTheImpactOfLanguageRuntimeOnThePerformanceAndCostOfServerlessFunctions.pdf)
   [ppt](https://www.serverlesscomputing.org/wosc4/presentations/p5-UCC-Presentation.pdf)
   
   + 研究不同Language runtime对性能的影响
   + 解析性语言性能更高(NodeJs/Python)
   
3. [Architectural Implications of Function-as-a-Service Computing]()

   + 研究无服务器计算引擎的基于Container实现的性能开销
   + containerization (20x slowdown)
   + cold-start (>10x duration)
   + interference (35% IPC reduction)

   
4. [Compute Abstractions on AWS A Visual Story](https://amazonaws-china.com/cn/blogs/architecture/compute-abstractions-on-aws-a-visual-story/)

   + 总结了AWS在计算抽象化上的发展
   + AWS Lambda-->AWS StepFunction
   + AWS Fargate
   
5. [Cloud Programming Simplified: A Berkeley View on Serverless Computing](https://arxiv.org/pdf/1902.03383.pdf)
   
   + 总结了AWS Lambda的各种特征
   + AWS Lambda的热启动技术：
     One approach, reflected in AWS Lambda, is maintaining a “warm pool” of VM instances
that need only be assigned to a tenant, and an “active pool” of instances that have been used to
run a function before and are maintained to serve future invocations [13]. The resource lifecycle
management and multi-tenant bin packing necessary to achieve high utilization are key technical
enablers of serverless computing
   
## 开源技术

1. [Serverless computation with OpenLambda](https://www.usenix.org/system/files/conference/hotcloud16/hotcloud16_hendrickson.pdf)
   [ppt]()
   
   + 研究无服务器计算引擎的沙箱技术
   + 第一代： VM
   + 第二代： Container, 以及存在的Cold-Start性能问题
   + 第三代： Lambda
   
## 研究组织

1. [The SPEC Cloud Group’s Research Vision on FaaS and Serverless Architectures]()

   + 区分"Serverless"和"FaaS"， Serverless包含FaaS，还涉及部分PaaS/SaaS以及BaaS，举例：Auth0(serverless authentication), and Fauna(serverless database)、 (Mobile-)Backend-as-a-Service focuses more than Faas on operational logic
   + Event/Business Integrations
   + Function/Business Logic
   + Operational Logic
