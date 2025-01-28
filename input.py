commands = ["(load nutricion.clp)",
            "(load main.clp)",
            "(reset)",
            "(run)",
            ]


for command in commands:
    print(command)

try:
    while True:
        print(input())
        
except:
    pass
