# Практическое задание по теме «Работа в терминале 1»

1. Установил Virtualbox
2. Установил Vagrant
3. Создал папку `vagrant` командой `mkdir vagrant` 
4. Далее, изменил содержимое `Vagrantfile` на то, что представлено в задании и запустил `vagrant up`

Получил ошибку, связанную с санкциями :
```bash
==> default: Box 'bento/ubuntu-20.04' could not be found. Attempting to find and install...
    default: Box Provider: virtualbox
    default: Box Version: >= 0
The box 'bento/ubuntu-20.04' could not be found or
could not be accessed in the remote catalog. If this is a private
box on HashiCorp's Vagrant Cloud, please verify you're logged in via
`vagrant login`. Also, please double-check the name. The expanded
URL and error message are shown below:

URL: ["https://vagrantcloud.com/bento/ubuntu-20.04"]
Error: The requested URL returned error: 404

```



5. Для решения задания буду использовать Ubuntu 20.04.1 поднятой на VMware Workstation
[Ubuntu 20.04.1](img/screen1.png)
# Ответы 



8. Ознакомиться с разделами `man bash`, почитать о настройках самого bash:

* какой переменной можно задать длину журнала `history`, и на какой строчке manual это описывается?

  1. Посмотрим на каких строках упоминается команда `history` командой `man bash | grep -n history`
  2. После этого командой `man bash | sed -n 'X,+Yp'` посмотрим упоминания команды и найдём переменную задающую длину журнала. Командой `cat -n` выведем номера строк

```bash
man bash | grep -n history
```

```bash
...
624:              quent lines of a multi-line compound command are not tested, and are added to the history regardless of the value of HISTCONTROL.
626:              The name of the file in which command history is saved (see HISTORY below).  The default value is ~/.bash_history.  If unset, the command history is not saved when a shell exits.
628:              The  maximum number of lines contained in the history file.  When this variable is assigned a value, the history file is truncated, if necessary, to contain no more than that number of
...
```

```bash
man bash | cat -n | sed -n '620,+20p'
```

```bash
...
627	       HISTFILESIZE
628	              The  maximum number of lines contained in the history file.  When this variable is assigned a value, the history file is truncated, if necessary, to contain no more than that number of
...
```

Переменная `HISTFILESIZE` задаёт длину журнала `history`, описывается на 627-628 строках.

* что делает директива `ignoreboth` в bash?

```bash
man bash | grep -B 2 -A 3 ignoreboth
```

```bash
HISTCONTROL
        A  colon-separated  list of values controlling how commands are saved on the history list.  If the list of values includes ignorespace, lines which begin with a space character are not
        saved in the history list.  A value of ignoredups causes lines matching the previous history entry to not be saved.  A value of ignoreboth is shorthand for ignorespace and  ignoredups.
        A value of erasedups causes all previous lines matching the current line to be removed from the history list before that line is saved.  Any value not in the above list is ignored.  If
        HISTCONTROL is unset, or does not include a valid value, all lines read by the shell parser are saved on the history list, subject to the value of HISTIGNORE.  The  second  and  subse‐
        quent lines of a multi-line compound command are not tested, and are added to the history regardless of the value of HISTCONTROL.         
```

Директива `ignoreboth` является сокращением для `ignorespace` и `ignoredups`. `ignorespace` — игнорирование строк, начинающихся с пробела. `ignoredups` — игнорирование строк-дубликатов предыдущих.

9. В каких сценариях использования применимы скобки `{}` и на какой строчке `man bash` это описано?

```bash
man bash | grep -n {
```

Фигурные скобки `{}` используются для вызова списка в командах. Например, создать папки с названиями 1, 2, ..., 10: `mkdir folder_{1..10}`. Описание на 206 строке.

10. С учётом ответа на предыдущий вопрос, как создать однократным вызовом `touch` 100000 файлов? Получится ли аналогичным образом создать 300000? Если нет, то почему?

```bash
touch {1..100000}
```

100000 файлов создалось. 300000 нет, получил ошибку: `Argument list too long`. Существует ограничение на максимальное количество аргументов в команде. 

```bash
getconf ARG_MAX
```

```bash
2097152
```

11. В man bash поищите по `/\[\[`. Что делает конструкция `[[ -d /tmp ]]`?

```bash
man bash | grep "\[\["
```

Конструкция `[[ -d /tmp ]]` возвращает 1, если выражение в скобках верное, 0 — если не верное.

```bash
[[ -d /tmp ]] && echo True
```

```bash
True
```

12. Основываясь на знаниях о просмотре текущих (например, PATH) и установке новых переменных; командах, которые мы рассматривали, добейтесь в выводе `type -a bash` в виртуальной машине наличия первым пунктом в списке:

	```bash
	bash is /tmp/new_path_directory/bash
	bash is /usr/local/bin/bash
	bash is /bin/bash
	```

	(прочие строки могут отличаться содержимым и порядком)
    В качестве ответа приведите команды, которые позволили вам добиться указанного вывода или соответствующие скриншоты.

```bash
mkdir /tmp/new_path_directory
cp /bin/bash /tmp/new_path_directory/bash
export PATH="/tmp/new_path_directory:$PATH"  

type -a bash
```

```bash
bash is /tmp/new_path_directory/bash
bash is /usr/bin/bash
bash is /bin/bash
```

13. Чем отличается планирование команд с помощью `batch` и `at`?

`at` запускает команду в назначенное время.

`batch` запускает команду при достижении определённого уровня нагрузки системы.