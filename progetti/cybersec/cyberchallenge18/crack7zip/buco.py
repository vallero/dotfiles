from pwn import *

# io = process(["access_denied", "ciao"])
context.terminal = "urxvt"
io = gdb.debug("/bin/cat")
io.interactive()
# io = process("cat")

# --- debugger
# pid = util.proc.pidof(io)[0]
# print("The pid is ", pid)
# util.proc.wait_for_debugger(pid)

# io.send("ciao ciao")
# print("wow")
# print(io.recvline())
# print("wow")
# print(io.recvline())
# print(io.recvline())


# shellcode_address = p32(u32(stack_address) + 0x14)
# print("stack_address", hex(u32(stack_address)))
# print("shellcode_address", hex(u32(shellcode_address)))

# io.interactive()




2 10 7 9 0 4 3 5 8 6 1

2 4    k - a v












1010111111111110
  10011100010000
 1100001++++----
