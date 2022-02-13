NAME			=	make_example

H_FOLDER		=	includes
C_FOLDER		=	src
OBJ_FOLDER		=	obj
FOLDER_LIST		=	$(H_FOLDER) $(C_FOLDER) $(OBJ_FOLDER)

H_FILES			=	$(NAME).h
C_FILES			=	$(NAME).c print1.c print2.c

H_PATHS			=	$(addprefix $(H_FOLDER)/, $(H_FILES))
C_PATHS			=	$(addprefix $(C_FOLDER)/, $(C_FILES))
OBJ_PATHS		=	$(addprefix $(OBJ_FOLDER)/, $(patsubst %.c, %.o, $(C_FILES)))

C_FLAGS			=	-Wall -Wextra -Werror
C_FLAGS			+=	-g

.PHONY: all
all: $(NAME)

$(NAME): pre_requisites $(OBJ_PATHS) Makefile
	clang $(C_FLAGS) -I $(H_FOLDER) -o $@ $(OBJ_PATHS)

$(OBJ_PATHS): $(OBJ_FOLDER)/%.o:$(C_FOLDER)/%.c $(H_PATHS) Makefile
	clang $(C_FLAGS) -I $(H_FOLDER) -c $< -o $@

pre_requisites: $(FOLDER_LIST) $(H_PATHS) $(C_PATHS)
	@touch pre_requisites

$(FOLDER_LIST):
	mkdir $@

$(H_PATHS):
	touch $@

$(C_PATHS):
	touch $@

.PHONY: print_files
print_files:
	@echo "H paths:   $(H_PATHS)"
	@echo "C paths:   $(C_PATHS)"
	@echo "OBJ paths: $(OBJ_PATHS)"
	@echo "C flags:   $(C_FLAGS)"
	@echo ""

.PHONY: clean
clean:
	-@rm -f $(OBJ_PATHS)
	@echo "All object files are removed!"

.PHONY: fclean
fclean: clean
	-@rm -f $(NAME)
	@echo "$(NAME) file is removed!"

.PHONY: re
re: fclean all
